" 'fileTypes': [
"   'tw'
" ]

" 'name': 'SugarCube 2'
" 'patterns': [
"   {
"     'include': '#variable'
"   }

"   {
"     'begin': '{{{|<nowiki>|"""'
"     'beginCaptures':
"       '0':
"         'name': 'support.sugar-cube'
"     'end': '}}}|</nowiki>|"""'
"     'endCaptures':
"       '0':
"         'name': 'support.sugar-cube'
"     'name': 'markup.raw.sugar-cube'
"   }

"   {
"     'begin': '\\^\\^'
"     'beginCaptures':
"       '0':
"         'name': 'support.sugar-cube'
"     'end': '\\^\\^'
"     'endCaptures':
"       '0':
"         'name': 'support.sugar-cube'
"     'name': 'markup.raw.sugar-cube'
"   }

"   {
"     'begin': '=='
"     'beginCaptures':
"       '0':
"         'name': 'support.sugar-cube'
"     'end': '=='
"     'endCaptures':
"       '0':
"         'name': 'support.sugar-cube'
"     'name': 'markup.raw.sugar-cube'
"   }

"   {
"     'begin': '~~'
"     'beginCaptures':
"       '0':
"         'name': 'support.sugar-cube'
"     'end': '~~'
"     'endCaptures':
"       '0':
"         'name': 'support.sugar-cube'
"     'name': 'markup.raw.sugar-cube'
"   }

"   {
"     'match': '--'
"     'name': 'markup.raw.sugar-cube'
"   }

  " {
  "   'comment': 'Captures link groups'
  "   'begin': '\\['
  "   'beginCaptures':
  "     '0':
  "       'name': 'keyword.control.sugar-cube'
  "   'end': '\\]'
  "   'endCaptures':
  "     '0':
  "       'name': 'keyword.control.sugar-cube'
  "   'patterns': [
  "     {
  "       'begin': '(\\[)'
  "       'beginCaptures':
  "         '1':
  "           'name': 'keyword.control.sugar-cube'
  "       'end': '(\\])'
  "       'endCaptures':
  "         '1':
  "           'name': 'keyword.control.sugar-cube'
  "       'patterns': [
  "         {
  "           'include': '#variable'
  "         }
  "       ]
  "     }
  "   ]
  " }
" ]

" 'repository':
  " 'numbers':
  "   'match': '\\b([0-9]+\\.?[0-9]*)\\b'
  "   'name': 'constant.numeric.sugar-cube'
  " 'builtins':
  "   'match': '\\b(true|false)\\b'
  "   'name': 'constant.language.sugar-cube'
  " 'double_quotes_string':
  "   'name': 'string.double-quotes.sugar-cube'
  "   'match': '".*?"'
  " 'backticks_variable':
  "   'begin': '`'
  "   'beginCaptures':
  "     '0':
  "       'name': 'keyword.control.sugar-cube'
  "   'end': '`'
  "   'endCaptures':
  "     '0':
  "       'name': 'keyword.control.sugar-cube'
  "   'patterns': [
  "     {'include': '#variable'}
  "     {'include': '#double_quotes_string'}
  "   ]
  " 'variable':
  "   'captures':
  "     '1':
  "       'name': 'variable.other.member.sugar-cube'
  "     '2':
  "       'name': 'variable.other.member.sugar-cube'
  "   'match': '(?:(?<!\\$)(\\$[a-zA-Z_]+)|(_[a-zA-Z_]+))'
" 'scopeName': 'source.tw'


" Vim syntax file
" Language: Twee 2 w/ SugarCube
" Maintainer: Otto Modinos <ottomodinos@gmail.com>
" Latest Revision: 13 August 2017
" Version: 0.1
"
" TODO:
"   - add HTML and markdown basic highlights

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'twee'
endif

syn keyword tweeBoolean     contained true false
syn match   tweeNumber      contained '\d\+'
syn region  tweeString      contained start=+'+  skip=+\\\\\|\\'+  end=+'+ oneline
syn region  tweeString      contained start=+"+  skip=+\\\\\|\\"+  end=+"+ oneline

" syn keyword tweeOperator    contained lt lte gt gte eq not and or is to it
" syn match   tweeOperator    contained '>\|<\|>=\|<=\|==\|!=\|===\|!=='

syn match   tweeVariable              '$[$_a-zA-Z][$_0-9a-zA-Z]*'
" We don't treat __ like a variable because that messes with underlining
syn match   tweeVariable              '_[$a-zA-Z][$_0-9a-zA-Z]*'

syn region  tweeEndMacro              start=+<</+ end=+>>+ contains=tweeMacroName
syn region  tweeMacro                 start=+<<+  end=+>>+ contains=tweeMacroName,tweeVariable,tweeBoolean,tweeNumber,tweeString,tweeOperator
syn match   tweeMacroName   contained '<<\s*[=-]'ms=s+2
syn match   tweeMacroName   contained '<<\s*[a-zA-Z][-_0-9a-zA-Z]*'ms=s+2
syn match   tweeMacroName   contained '<</\s*[=-]'ms=s+3
syn match   tweeMacroName   contained '<</\s*[a-zA-Z][-_0-9a-zA-Z]*'ms=s+3

syn match   tweePassageTitle          '^::.*$' contains=tweePassageTags
syn match   tweePassageTags contained '\[.*\]'

" FIXME
syn region  tweeLink                  start=+\[\[+ end=+\]\]+
" syn region  tweeLinkLink    contained start=+\[+ end=+\]+ contains=tweeLinkText keepend nextgroup=tweeLinkSetter
" syn match   tweeLinkText    contained '.*|'me=e-1
" syn match   tweeLinkText    contained '.*->'me=e-2
" syn match   tweeLinkText    contained '<-.*'ms=s+2
" syn region  tweeLinkSetter  contained start=+\[+ end=+\]+ contains=tweeVariable,tweeBoolean,tweeNumber,tweeString

syn region  tweeComment               start=+/%+ end=+%/+ contains=tweeTodo
syn region  tweeComment               start=+/\*+ end=+\*/+ contains=tweeTodo
syn region  tweeComment               start=+<!--+ end=+-->+ contains=tweeTodo
syn keyword tweeTodo        contained TODO XXX FIXME

syn region  tweeStyle                 start=+@@+ end=+@@+ contains=tweeStyleList
syn match   tweeStyleList   contained '@@\([#.a-zA-Z:_-]\+;\)*'ms=s+2

syn region  tweeHTML                              start=+<html>+ end=+</html>+

syn cluster tweeTop contains=tweeLink,tweeVariable,tweeMacro,tweeEndMacro

syn region  tweeBold                              start=+''+ end=+''+ contains=@tweeTop,tweeBoldItalic,tweeBoldUnderline
syn region  tweeBoldItalic              contained start=+//+ end=+//+ contains=@tweeTop,tweeBoldItalicUnderline
syn region  tweeBoldUnderline           contained start=+__+ end=+__+ contains=@tweeTop,tweeBoldUnderlineItalic
syn region  tweeBoldItalicUnderline     contained start=+__+ end=+__+ contains=@tweeTop
syn region  tweeBoldUnderlineItalic     contained start=+//+ end=+//+ contains=@tweeTop

syn region  tweeItalic                            start=+//+ end=+//+ contains=@tweeTop,tweeItalicBold,tweeItalicUnderline
syn region  tweeItalicBold              contained start=+''+ end=+''+ contains=@tweeTop,tweeItalicBoldUnderline
syn region  tweeItalicUnderline         contained start=+__+ end=+__+ contains=@tweeTop,tweeItalicUnderlineBold
syn region  tweeItalicBoldUnderline     contained start=+__+ end=+__+ contains=@tweeTop
syn region  tweeItalicUnderlineBold     contained start=+''+ end=+''+ contains=@tweeTop

syn region  tweeUnderline                         start=+__+ end=+__+ contains=@tweeTop,tweeUnderlineBold,tweeUnderlineItalic
syn region  tweeUnderlineBold           contained start=+''+ end=+''+ contains=@tweeTop,tweeUnderlineBoldItalic
syn region  tweeUnderlineItalic         contained start=+//+ end=+//+ contains=@tweeTop,tweeUnderlineItalicBold
syn region  tweeUnderlineBoldItalic     contained start=+//+ end=+//+ contains=@tweeTop
syn region  tweeUnderlineItalicBold     contained start=+''+ end=+''+ contains=@tweeTop

"
" Highlight colors
hi def link tweeBoolean     Boolean
hi def link tweeNumber      Number
hi def link tweeString      String
hi def link tweeOperator    Operator

hi def link tweeVariable    Identifier
hi def link tweeMacroName   Function

hi def link tweeLink        Identifier

hi def link tweeComment     Comment
hi def link tweeTodo        ToDo

hi def link tweePassageTitle   Title
hi def link tweePassageTags    Type


hi def link tweeUnderlineBold           tweeBoldUnderline
hi def link tweeUnderlineBoldItalic     tweeBoldItalicUnderline
hi def link tweeUnderlineItalic         tweeItalicUnderline
hi def link tweeUnderlineItalicBold     tweeBoldItalicUnderline
hi def link tweeBoldUnderlineItalic     tweeBoldItalicUnderline
hi def link tweeItalicBold              tweeBoldItalic
hi def link tweeItalicBoldUnderline     tweeBoldItalicUnderline
hi def link tweeItalicUnderlineBold     tweeBoldItalicUnderline

hi def tweeBold                 term=bold                   cterm=bold                  gui=bold
hi def tweeBoldItalic           term=bold,italic            cterm=bold,italic           gui=bold,italic
hi def tweeBoldUnderline        term=bold,underline         cterm=bold,underline        gui=bold,underline
hi def tweeBoldItalicUnderline  term=bold,italic,underline  cterm=bold,italic,underline gui=bold,italic,underline
hi def tweeItalic               term=italic                 cterm=italic                gui=italic
hi def tweeItalicUnderline      term=italic,underline       cterm=italic,underline      gui=italic,underline
hi def tweeUnderline            term=underline              cterm=underline             gui=underline


let b:current_syntax = 'twee'
if main_syntax == 'twee'
  unlet main_syntax
endif
