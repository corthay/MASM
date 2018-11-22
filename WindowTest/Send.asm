		.386
		.model flat,stdcall
		option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;include
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include		windows.inc
include		user32.inc
includelib	user32.lib
include		kernel32.inc
includelib	kernel32.lib
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;data
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				.data
hWnd			dd		?
szBuffer		db		256	dup	(?)
				.const
szCaption		db		'SendMassage',0
szStart			db		'Press	ok',0
szReturn		db		'SendMessage returned',0
szDestClass		db		'MyClass',0
szDestWnd		db		'My first Window',0
szText			db		'Æô¶¯Overwatch',0
szNotFound		db		'Not found',0

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			.code
start:
			invoke		FindWindow,addr	szDestClass,addr szDestWnd
			.if			eax
						mov			hWnd,eax
						invoke		wsprintf,addr szBuffer,addr szStart,addr szText	
						invoke		MessageBox,NULL,offset szBuffer,offset szCaption,MB_OK
						invoke		SendMessage,hWnd,WM_SETTEXT,0,addr szText
						invoke		MessageBox,NULL,offset szReturn,offset szCaption,MB_OK
			.else		
						invoke		MessageBox,NULL,offset szNotFound,offset szCaption,MB_OK
			.endif
			invoke		ExitProcess,NULL
			end			start
