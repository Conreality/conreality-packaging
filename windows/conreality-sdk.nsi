; This is free and unencumbered software released into the public domain.

!include MUI2.nsh

!define /file VERSION "${SDK}/VERSION"

SetCompressor /solid /final lzma
OutFile "${OUTFILE}"

Name "Conreality SDK"
Caption "Conreality SDK ${VERSION} (${TARGET}) Setup"
Unicode true
BrandingText " "

VIProductVersion "${VERSION}.0"
VIAddVersionKey  OriginalFilename "${OUTFILE}"
VIAddVersionKey  FileDescription "Conreality SDK Installer"
VIAddVersionKey  FileVersion "${VERSION}"
VIAddVersionKey  ProductName "Conreality Software Development Kit"
VIAddVersionKey  ProductVersion "${VERSION} (${TARGET})"
VIAddVersionKey  LegalCopyright "Public Domain"
VIAddVersionKey  LegalTrademarks "Conreality is a trademark of Conreality Ltd."
VIAddVersionKey  CompanyName "Conreality Ltd."
VIAddVersionKey  Comments "https://sdk.conreality.dev"

InstallDir "$PROGRAMFILES64\Conreality\SDK"
InstallDirRegKey HKLM Software\Conreality\SDK ""
RequestExecutionLevel admin

;Remember the installer language
!define MUI_LANGDLL_REGISTRY_ROOT "HKCU"
!define MUI_LANGDLL_REGISTRY_KEY "Software\Conreality\SDK"
!define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

!define MUI_LANGDLL_WINDOWTITLE "Conreality SDK ${VERSION} (${TARGET}) Setup"

!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico" ; TODO
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"
!define MUI_BGCOLOR 303030
!define MUI_TEXTCOLOR FFFFFF
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "header.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "welcome.bmp"
!define MUI_LICENSEPAGE_BGCOLOR /grey

!define MUI_COMPONENTSPAGE_NODESC

!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_LINK "Conreality SDK documentation (sdk.conreality.dev)"
!define MUI_FINISHPAGE_LINK_LOCATION "https://sdk.conreality.dev"
!define MUI_FINISHPAGE_LINK_COLOR FFFFFF
!define MUI_FINISHPAGE_NOREBOOTSUPPORT

!define MUI_UNFINISHPAGE_NOAUTOCLOSE

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English" ; default
!insertmacro MUI_LANGUAGE "Russian"
!insertmacro MUI_LANGUAGE "Ukrainian"

!insertmacro MUI_RESERVEFILE_LANGDLL

Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Function un.onInit
  !insertmacro MUI_UNGETLANGUAGE
FunctionEnd

Section
  SetOutPath $INSTDIR
  SetRegView 32
  WriteRegStr HKLM Software\Conreality\SDK "" $INSTDIR
  WriteRegStr HKLM Software\Conreality\SDK "Version" "${VERSION}"
  SetRegView 64
  WriteRegStr HKLM Software\Conreality\SDK "" $INSTDIR
  WriteRegStr HKLM Software\Conreality\SDK "Version" "${VERSION}"
  WriteUninstaller $INSTDIR\Uninstall.exe
  File /oname=README.txt conreality-sdk/README.txt
  File /oname=LICENSE.txt ${SDK}/UNLICENSE
  File /oname=VERSION.txt ${SDK}/VERSION
SectionEnd

SectionGroup "Library"
Section "Shared Runtime Library"
  SetOutPath $INSTDIR
  CreateDirectory $INSTDIR\Libraries
  File /oname=Libraries\conreality.dll ${SDK}/build/windows/x86_64/conreality.dll
  File /oname=Libraries\conreality.lib ${SDK}/build/windows/x86_64/conreality.lib
  File /oname=Libraries\conreality.pdb ${SDK}/build/windows/x86_64/conreality.pdb
SectionEnd
Section "Static Development Library"
  SetOutPath $INSTDIR
  CreateDirectory $INSTDIR\Libraries
  File /oname=Libraries\libconreality.lib ${SDK}/build/windows/x86_64/libconreality.lib
SectionEnd
SectionGroupEnd

SectionGroup "Headers"
Section "Development Headers for C"
  SetOutPath $INSTDIR
  CreateDirectory $INSTDIR\Headers
  File /oname=Headers\conreality.h ${SDK}/c/conreality.h
SectionEnd
Section "Development Headers for C++"
  SetOutPath $INSTDIR
  CreateDirectory $INSTDIR\Headers
  File /oname=Headers\conreality.hpp ${SDK}/cpp/conreality.hpp
SectionEnd
SectionGroupEnd

Section "Examples"
  SetOutPath $INSTDIR
  CreateDirectory $INSTDIR\Examples
SectionEnd

Section "Uninstall"
  Delete $INSTDIR\Uninstall.exe
  Delete $INSTDIR\README.txt
  Delete $INSTDIR\LICENSE.txt
  Delete $INSTDIR\VERSION.txt
  Delete $INSTDIR\conreality.dll
  Delete $INSTDIR\conreality.lib
  Delete $INSTDIR\conreality.pdb
  Delete $INSTDIR\libconreality.lib
  RMDir /r $INSTDIR\Examples
  RMDir /r $INSTDIR\Headers
  RMDir /r $INSTDIR\Libraries
  RMDir $INSTDIR
  SetRegView 32
  DeleteRegKey /ifempty HKCU Software\Conreality\SDK
  DeleteRegKey /ifempty HKLM Software\Conreality\SDK
  SetRegView 64
  DeleteRegKey /ifempty HKCU Software\Conreality\SDK
  DeleteRegKey /ifempty HKLM Software\Conreality\SDK
SectionEnd
