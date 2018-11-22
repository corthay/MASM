		.386
		.model flat,stdcall
		option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;include
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include		windows.inc
include		gdi32.inc
includelib	gdi32.lib
include		user32.inc
includelib	user32.lib
include		kernel32.inc
includelib	kernel32.lib
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;data
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					.data?
hInstance			dd		?
hWinMain			dd		?
					.const
szClassName			db		'MyClass',0
szCaptionMain		db		'My first Window',0
szText				db		'Yeah',0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			.code
_Proc		proc		uses ebx edi esi hWnd,uMsg,wParam,lParam
			
			mov			eax,uMsg

			.if			eax==WM_CLOSE
						invoke	DestroyWindow,hWinMain
						invoke	PostQuitMessage,NULL
			;Click close button to close window directly

						
			.else
						invoke	DefWindowProc,hWnd,uMsg,wParam,lParam
						ret
			.endif
			
			xor			eax,eax
			ret
_Proc		endp
;------------------------------------------------------------
;Window
;------------------------------------------------------------
_WinMain	proc
			local		@stWndClass:WNDCLASSEX
			local		@stMsg

			invoke		GetModuleHandle,NULL
			mov			hInstance,eax
			
			invoke		RtlZeroMemory,addr @stWndClass,sizeof @stWndClass
			mov			@stWndClass.cbSize,sizeof @stWndClass
			mov			@stWndClass.style,CS_HREDRAW OR CS_VREDRAW
			mov			@stWndClass.lpfnWndProc,offset _Proc
			push		hInstance
			pop			@stWndClass.hInstance
			invoke		LoadCursor,0,IDC_ARROW
			mov			@stWndClass.hCursor,eax
			mov			@stWndClass.hbrBackground,COLOR_WINDOW + 1
			mov			@stWndClass.lpszClassName,offset szClassName
			invoke		RegisterClassEx,addr @stWndClass
			;Register a window class
			invoke		CreateWindowEx,WS_EX_CLIENTEDGE,\
						offset szClassName,\
						offset szCaptionMain,\
						WS_OVERLAPPEDWINDOW,\
						100,100,600,400,\
						NULL,NULL,\
						hInstance,\
						NULL
			mov			hWinMain,eax
			invoke		ShowWindow,hWinMain,SW_SHOWNORMAL
			invoke		UpdateWindow,hWinMain
			;Create a window and show it
			.while		TRUE
						invoke	GetMessage,addr @stMsg,NULL,0,0
						.break	.if	eax==0
						invoke	TranslateMessage,addr @stMsg
						invoke	DispatchMessage,addr @stMsg
			.endw
			;Dispatch the massage to other subprogram
			ret
_WinMain	endp
			
start:
			call		_WinMain
			invoke		ExitProcess,NULL
			end		start
