// BackToIndentationDwimCommand.h
//
// Copyright (c) 2017 Daniel Martín
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <XcodeKit/XcodeKit.h>

/**
 * Implementation of a modified version of back-to-indentation:
 *   - When the point is at the first non-whitespace character of the line, go to the beginning of the line.
 *   - Otherwise, go to the first non-whitespace character of the line.
 *
 * Here's my original Elisp implementation:
 *
 * (defun back-to-indentation-dwim ()
 *   "Toggle between moving the point to the start of the first non-whitespace character and the start of the line."
 *   (interactive)
 *   (let ((start-position (point)))
 *     ;; Move to the first non-whitespace character.
 *     (back-to-indentation)
 *     ;; If we haven't moved, go to the start of the line.
 *     (when (= (point) start-position)
 *       (move-beginning-of-line nil))))
 */
@interface BackToIndentationDwimCommand : NSObject <XCSourceEditorCommand>

@end
