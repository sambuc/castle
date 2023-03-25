" Vim syntax file
" Language:	UMLSpeed
" Maintainer:	Robin Rawson-Tetley <robin@rawsontetley.org>
" Last Change:	2007 May 03

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" UMLSpeed keywords
syn keyword	uMeta		import namespace
syn keyword	uEntity 	class interface actor usecase classdiagram usecasediagram sequencediagram deploymentdiagram component deployment 
syn keyword	uCollection	operations fields entities visuals contents
syn keyword	uRelationship	uses extends includes depends implements onetoone onetomany manytomany manytoone creates invokes invokesasync
syn keyword	uProperty	comment layout modifiers entity_margin documentation name type platform
syn keyword 	uModifier	public private friend abstract component software node database
syn keyword	uType		void grid satellite hierarchy
syn keyword	uTodo		contained TODO FIXME XXX

" These are arbitrary types from various languages, just to help remind folks
syn keyword     javaTypes	Boolean Byte Char Integer Long Float Double String StringBuffer File List Hashmap Hashtable Collection Enum ArrayList Vector
syn keyword  	cTypes		boolean byte char int long float double
syn keyword  	cSharpTypes	string bool

" Regions (strings, comments)
syn match       cSpecial        display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
syn region    	cString         start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial,@Spell
syn region 	cCommentS	start="/\*" end="\*/" contains=cSpecial,uTodo
syn region 	cCommentL	start="//" skip="\\$" end="$" 

" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link uMeta		Include
hi def link uEntity		StorageClass
hi def link uCollection		Statement
hi def link uProperty		Conditional
hi def link uRelationship	Label
hi def link uModifier		Label
hi def link uType		Type
hi def link uTodo		Todo
hi def link cCommentL		Comment
hi def link cCommentS		Comment
hi def link cString		String
hi def link cTypes		Type
hi def link cSharpTypes		Type
hi def link javaTypes		Type

let b:current_syntax = "umlspeed"

" vim: ts=8
