// BackToIndentationDwimCommand.m
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

#import "BackToIndentationDwimCommand.h"

@implementation BackToIndentationDwimCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation
                   completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
  // This command only makes sense when there's only one active selection that represents a single point in the buffer.
  if (invocation.buffer.selections.count == 1) {
    XCSourceTextRange *range = invocation.buffer.selections[0];
    if (range.start.line == range.end.line &&
        range.start.column == range.end.column) {
      NSString *currentLine = invocation.buffer.lines[range.start.line];
      NSUInteger idx;
      NSCharacterSet *whitespaceCharacterSet = [NSCharacterSet whitespaceCharacterSet];
      for (idx = 0; idx < currentLine.length && [whitespaceCharacterSet characterIsMember:[currentLine characterAtIndex:idx]]; ++idx) {}
      [invocation.buffer.selections removeAllObjects];
      if (idx == range.start.column) {
        XCSourceTextRange *beginningOfLine = [[XCSourceTextRange alloc] initWithStart:XCSourceTextPositionMake(range.start.line, 0)
                                                                                  end:XCSourceTextPositionMake(range.start.line, 0)];
        [invocation.buffer.selections addObject:beginningOfLine];
      } else {
        XCSourceTextRange *firstNonWhitespace = [[XCSourceTextRange alloc] initWithStart:XCSourceTextPositionMake(range.start.line, idx)
                                                                                     end:XCSourceTextPositionMake(range.start.line, idx)];
        [invocation.buffer.selections addObject:firstNonWhitespace];
      }
    }
  }

  completionHandler(nil);
}

@end
