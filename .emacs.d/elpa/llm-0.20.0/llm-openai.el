;;; llm-openai.el --- llm module for integrating with Open AI -*- lexical-binding: t; package-lint-main-file: "llm.el"; byte-compile-docstring-max-column: 200-*-

;; Copyright (c) 2023, 2024  Free Software Foundation, Inc.

;; Author: Andrew Hyatt <ahyatt@gmail.com>
;; Homepage: https://github.com/ahyatt/llm
;; SPDX-License-Identifier: GPL-3.0-or-later
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3 of the
;; License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; This file implements the llm functionality defined in llm.el, for Open AI's
;; API.

;;; Code:

(require 'cl-lib)
(require 'llm)
(require 'llm-provider-utils)
(require 'llm-models)
(require 'json)
(require 'plz-event-source)

(defgroup llm-openai nil
  "LLM implementation for Open AI."
  :group 'llm)

(defcustom llm-openai-example-prelude "Examples of how you should respond follow."
  "The prelude to use for examples in Open AI chat prompts."
  :type 'string
  :group 'llm-openai)

(cl-defstruct (llm-openai (:include llm-standard-full-provider))
  "A structure for holding information needed by Open AI's API.

KEY is the API key for Open AI, which is required.

CHAT-MODEL is the model to use for chat queries.  If unset, it
will use a reasonable default.

EMBEDDING-MODEL is the model to use for embeddings.  If unset, it
will use a reasonable default."
  key (chat-model "gpt-4o") (embedding-model "text-embedding-3-small"))

(cl-defstruct (llm-openai-compatible (:include llm-openai
                                               (chat-model nil)
                                               (embedding-model nil)))
  "A structure for other APIs that use the Open AI's API.

URL is the URL to use for the API, up to the command.  So, for
example, if the API for chat is at
https://api.example.com/v1/chat, then URL should be
\"https://api.example.com/v1/\"."
  url)

(cl-defmethod llm-nonfree-message-info ((_ llm-openai))
  "Return Open AI's nonfree terms of service."
  "https://openai.com/policies/terms-of-use")

(cl-defmethod llm-provider-embedding-request ((provider llm-openai) string-or-list)
  "Return the request to the server for the embedding of STRING-OR-LIST.
PROVIDER is the Open AI provider struct."
  `(("input" . ,string-or-list)
    ("model" . ,(llm-openai-embedding-model provider))))

(cl-defmethod llm-provider-batch-embeddings-request ((provider llm-openai) batch)
  (llm-provider-embedding-request provider batch))

(cl-defmethod llm-provider-embedding-extract-result ((_ llm-openai) response)
  "Return the embedding from the server RESPONSE."
  (assoc-default 'embedding (aref (assoc-default 'data response) 0)))

(cl-defmethod llm-provider-batch-embeddings-extract-result ((_ llm-openai) response)
  "Return the embedding from the server RESPONSE."
  (let* ((data (assoc-default 'data response))
         (vec (make-vector (length data) nil)))
    (mapc (lambda (d)
            (aset vec (assoc-default 'index d)
                  (assoc-default 'embedding d)))
          data)
    (append vec nil)))

(cl-defgeneric llm-openai--check-key (provider)
  "Check that the key is set for the Open AI PROVIDER.")

(cl-defmethod llm-openai--check-key ((provider llm-openai))
  (unless (llm-openai-key provider)
    (error "To call Open AI API, add a key to the `llm-openai' provider")))

(cl-defmethod llm-openai--check-key ((_ llm-openai-compatible))
  ;; It isn't always the case that a key is needed for Open AI compatible APIs.
  )

(cl-defmethod llm-provider-request-prelude ((provider llm-openai))
  (llm-openai--check-key provider))

;; Obsolete, but we keep them here for backward compatibility.
(cl-defgeneric llm-openai--headers (provider)
  "Return the headers to use for a request from PROVIDER.")

(cl-defmethod llm-openai--headers ((provider llm-openai))
  (when-let ((key (llm-openai-key provider)))
    ;; If the key is a function, call it.  The `auth-source' API uses functions
    ;; to wrap secrets and to obfuscate them in the Emacs heap.
    (when (functionp key)
      (setq key (funcall key)))
    ;; Encode the API key to ensure it is unibyte.  The request library gets
    ;; confused by multibyte headers, which turn the entire body multibyte if
    ;; there’s a non-ascii character, regardless of encoding.  And API keys are
    ;; likely to be obtained from external sources like shell-command-to-string,
    ;; which always returns multibyte.
    `(("Authorization" . ,(format "Bearer %s" (encode-coding-string key 'utf-8))))))

(cl-defmethod llm-provider-headers ((provider llm-openai))
  (llm-openai--headers provider))

;; Obsolete, but we keep them here for backward compatibility.
(cl-defgeneric llm-openai--url (provider command)
  "Return the URL for COMMAND for PROVIDER.")

(cl-defmethod llm-openai--url ((_ llm-openai) command)
  (concat "https://api.openai.com/v1/" command))

(cl-defmethod llm-provider-embedding-url ((provider llm-openai) &optional _)
  (llm-openai--url provider "embeddings"))

(cl-defmethod llm-provider-chat-url ((provider llm-openai))
  (llm-openai--url provider "chat/completions"))

(cl-defmethod llm-openai--url ((provider llm-openai-compatible) command)
  "Return the URL for COMMAND for PROVIDER."
  (concat (llm-openai-compatible-url provider)
          (unless (string-suffix-p "/" (llm-openai-compatible-url provider))
            "/") command))

(cl-defmethod llm-provider-embedding-extract-error ((_ llm-openai) err-response)
  (let ((errdata (assoc-default 'error err-response)))
    (when errdata
      (format "Open AI returned error: %s message: %s"
              (cdr (assoc 'type errdata))
              (cdr (assoc 'message errdata))))))

(cl-defmethod llm-provider-chat-extract-error ((provider llm-openai) err-response)
  (llm-provider-embedding-extract-error provider err-response))

(defun llm-openai--response-format (format)
  "Return the Open AI response format for FORMAT."
  (if (eq format 'json) '(("type" . "json_object"))
    ;; If not JSON, this must be a json response spec.
    `(("type" . "json_schema")
      ("json_schema" . (("name" . "response")
                        ("strict" . t)
                        ("schema" . ,(append
                                      (llm-provider-utils-json-schema format)
                                      '(("additionalProperties" . :json-false)))))))))

(cl-defmethod llm-provider-chat-request ((provider llm-openai) prompt streaming)
  "From PROMPT, create the chat request data to send.
PROVIDER is the Open AI provider.
FUNCTIONS is a list of functions to call, or nil if none.
STREAMING if non-nil, turn on response streaming."
  (let (request-alist)
    (llm-provider-utils-combine-to-system-prompt prompt llm-openai-example-prelude)
    (when streaming (push `("stream" . ,t) request-alist))
    (push `("messages" .
            ,(mapcan (lambda (i)
                       (if (llm-chat-prompt-interaction-function-call-results i)
                           (mapcar (lambda (fc)
                                     (append
                                      (when (llm-chat-prompt-function-call-result-call-id fc)
                                        `(("tool_call_id" .
                                           ,(llm-chat-prompt-function-call-result-call-id fc))))
                                      `(("role" . "tool")
                                        ("name" . ,(llm-chat-prompt-function-call-result-function-name fc))
                                        ("content" . ,(llm-chat-prompt-function-call-result-result fc)))))
                                   (llm-chat-prompt-interaction-function-call-results i))
                         (list
                          (append
                           `(("role" . ,(llm-chat-prompt-interaction-role i)))
                           (when-let ((content (llm-chat-prompt-interaction-content i)))
                             (cond
                              ((listp content)
                               (llm-openai-function-call-to-response content))
                              ((llm-multipart-p content)
                               `(("content"  . ,(mapcar (lambda (part)
                                                          (if (llm-media-p part)
                                                              `(("type" . "image_url")
                                                                ("image_url"
                                                                 . (("url"
                                                                     . ,(concat
                                                                         "data:"
                                                                         (llm-media-mime-type part)
                                                                         ";base64,"
                                                                         (base64-encode-string (llm-media-data part)))))))
                                                            `(("type" . "text")
                                                              ("text" . ,part))))
                                                        (llm-multipart-parts content)))))
                              (t `(("content" . ,content)))))))))
                     (llm-chat-prompt-interactions prompt)))
          request-alist)
    (push `("model" . ,(llm-openai-chat-model provider)) request-alist)
    (when (llm-chat-prompt-response-format prompt)
      (push `("response_format" . ,(llm-openai--response-format
                                    (llm-chat-prompt-response-format prompt)))
            request-alist))
    (when (llm-chat-prompt-temperature prompt)
      (push `("temperature" . ,(* (llm-chat-prompt-temperature prompt) 2.0)) request-alist))
    (when (llm-chat-prompt-max-tokens prompt)
      (push `("max_tokens" . ,(llm-chat-prompt-max-tokens prompt)) request-alist))
    (when (llm-chat-prompt-functions prompt)
      (push `("tools" . ,(mapcar #'llm-provider-utils-openai-function-spec
                                 (llm-chat-prompt-functions prompt)))
            request-alist))
    (append request-alist (llm-chat-prompt-non-standard-params prompt))))

(cl-defmethod llm-provider-chat-extract-result ((_ llm-openai) response)
  (assoc-default 'content
                 (assoc-default 'message (aref (cdr (assoc 'choices response)) 0))))

(cl-defmethod llm-provider-extract-function-calls ((_ llm-openai) response)
  (mapcar (lambda (call)
            (let ((function (cdr (nth 2 call))))
              (make-llm-provider-utils-function-call
               :id (assoc-default 'id call)
               :name (assoc-default 'name function)
               :args (json-read-from-string
                      (let ((args (assoc-default 'arguments function)))
                        (if (= (length args) 0) "{}" args))))))
          (assoc-default 'tool_calls
                         (assoc-default 'message
                                        (aref (assoc-default 'choices response) 0)))))

(defun llm-openai-function-call-to-response (fcs)
  "Convert back from the generic representation to the Open AI.
FCS is a list of `make-llm-provider-utils-function-call'"
  `(("tool_calls" .
     ,(mapcar (lambda (fc)
                `(("id" . ,(llm-provider-utils-function-call-id fc))
                  ("type" . "function")
                  ("function" .
                   (("arguments" . ,(json-encode
                                     (llm-provider-utils-function-call-args fc)))
                    ("name" . ,(llm-provider-utils-function-call-name fc))))))
              fcs))))

(cl-defmethod llm-provider-populate-function-calls ((_ llm-openai) prompt calls)
  (llm-provider-utils-append-to-prompt prompt calls))

(defun llm-openai--get-partial-chat-response (response)
  "Return the text in the partial chat response from RESPONSE.
RESPONSE can be nil if the response is complete."
  (when response
    (let* ((choices (assoc-default 'choices response))
           (delta (when (> (length choices) 0)
                    (assoc-default 'delta (aref choices 0))))
           (content-or-call (or (assoc-default 'content delta)
                                (assoc-default 'tool_calls delta))))
      content-or-call)))

(cl-defmethod llm-provider-streaming-media-handler ((_ llm-openai) msg-receiver fc-receiver _)
  (cons 'text/event-stream
        (plz-event-source:text/event-stream
         :events `((message
                    .
                    ,(lambda (event)
                       (let ((data (plz-event-source-event-data event)))
                         (unless (equal data "[DONE]")
                           (when-let ((response (llm-openai--get-partial-chat-response
                                                 (json-read-from-string data))))
                             (funcall (if (stringp response) msg-receiver fc-receiver) response))))))))))

(cl-defmethod llm-provider-collect-streaming-function-data ((_ llm-openai) data)
  (let* ((num-index (+ 1 (assoc-default 'index (aref (car (last data)) 0))))
         (cvec (make-vector num-index nil)))
    (dotimes (i num-index)
      (setf (aref cvec i) (make-llm-provider-utils-function-call)))
    (cl-loop for part in data do
             (cl-loop for call in (append part nil) do
                      (let* ((index (assoc-default 'index call))
                             (id (assoc-default 'id call))
                             (function (assoc-default 'function call))
                             (name (assoc-default 'name function))
                             (arguments (assoc-default 'arguments function)))
                        (when id
                          (setf (llm-provider-utils-function-call-id (aref cvec index)) id))
                        (when name
                          (setf (llm-provider-utils-function-call-name (aref cvec index)) name))
                        (setf (llm-provider-utils-function-call-args (aref cvec index))
                              (concat (llm-provider-utils-function-call-args (aref cvec index))
                                      arguments)))))
    (cl-loop for call in (append cvec nil)
             do (setf (llm-provider-utils-function-call-args call)
                      (json-read-from-string (llm-provider-utils-function-call-args call)))
             finally return (when (> (length cvec) 0)
                              (append cvec nil)))))

(cl-defmethod llm-name ((_ llm-openai))
  "Return the name of the provider."
  "Open AI")

(cl-defmethod llm-chat-token-limit ((provider llm-openai))
  (llm-provider-utils-model-token-limit (llm-openai-chat-model provider)))

(cl-defmethod llm-capabilities ((provider llm-openai))
  (append '(streaming embeddings function-calls json-response)
          (when-let ((model (llm-models-match (llm-openai-chat-model provider))))
            (seq-intersection (llm-model-capabilities model)
                              '(image-input)))))

(cl-defmethod llm-capabilities ((provider llm-openai-compatible))
  (append '(streaming)
          (when (llm-openai-embedding-model provider)
            '(embeddings embeddings-batch))
          (let ((model (llm-models-match (llm-openai-chat-model provider))))
            (when (and model (member 'tool-use (llm-model-capabilities model)))
              '(function-calls)))))

(provide 'llm-openai)

;;; llm-openai.el ends here
