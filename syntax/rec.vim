" Syntax highlighting for .rec files
if exists("b:current_syntax")
  finish
endif

" Dividers
syn match recDivider /^–––.*–––$/

" Input, Output, Block
syn match recInputLabel /input/ contained
syn match recInput /^––– input –––$/ contains=recInputLabel
syn match recOutputLabel /output/ contained
syn match recOutput /^––– output –––$/ contains=recOutputLabel
syn match recBlockLabel /block:/ contained
syn match recBlockValue /\S\+/ contained
syn match recBlock /^––– block: \S\+ –––$/ contains=recBlockLabel,recBlockValue

" Duration
syn match recDurationLabel /duration:/ contained
syn match recDurationValue /\d\+\(\.\d\+\)\?[mµn]\?s/ contained
syn match recDuration /^––– duration: \d\+\(\.\d\+\)\?[mµn]\?s\s\+(\d\+\.\d\+%) –––/ contains=recDurationLabel,recDurationValue,recPercentage

" CPU Time
syn match recCPUTimeLabel /cpu time:/ contained
syn match recCPUTimeValue /\d\+\(\.\d\+\)\?[mµn]\?s/ contained
syn match recCPUTime /^––– cpu time: \d\+\(\.\d\+\)\?[mµn]\?s\s\+(\d\+\.\d\+%) –––/ contains=recCPUTimeLabel,recCPUTimeValue,recPercentage

" Memory
syn match recMemoryLabel /memory:/ contained
syn match recMemoryValue /\d\+\(\.\d\+\)\?\s\+[KMGTPEZY]\?B/ contained
syn match recMemory /^––– memory: \d\+\(\.\d\+\)\?\s\+[KMGTPEZY]\?B –––$/ contains=recMemoryLabel,recMemoryValue

" Percentage
syn match recPercentage /(\d\+\.\d\+%)/ contained

" Human-readable sizes
syn match recSize /\d\+\(\.\d\+\)\?\s\+[KMGTPEZY]\?B/

" Link highlight groups to colors
hi def link recDivider Structure
hi def link recInputLabel Keyword
hi def link recInput Statement
hi def link recOutputLabel Keyword
hi def link recOutput Statement
hi def link recBlockLabel Keyword
hi def link recBlockValue String
hi def link recBlock Statement
hi def link recDurationLabel Keyword
hi def link recDurationValue Number
hi def link recCPUTimeLabel Keyword
hi def link recCPUTimeValue Number
hi def link recMemoryLabel Keyword
hi def link recMemoryValue Number
hi def link recPercentage Type
hi def link recSize Constant

let b:current_syntax = "rec"
