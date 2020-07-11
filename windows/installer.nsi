; This is free and unencumbered software released into the public domain.

!include MUI2.nsh

!define SDK "../../conreality-sdk"
!define /file VERSION "${SDK}/VERSION"

SetCompressor /solid /final lzma
OutFile "installer.exe"

Name "Conreality SDK"
Caption "Conreality SDK ${VERSION} Setup"
Unicode true

VIProductVersion "${VERSION}.0"
VIAddVersionKey  OriginalFilename "installer.exe"
VIAddVersionKey  FileDescription "Conreality SDK Installer"
VIAddVersionKey  FileVersion "${VERSION}"
VIAddVersionKey  ProductName "Conreality Software Development Kit"
VIAddVersionKey  ProductVersion "${VERSION} (${TARGET})"
VIAddVersionKey  LegalCopyright "Public Domain"
VIAddVersionKey  LegalTrademarks "Conreality is a trademark of Conreality Ltd."
VIAddVersionKey  CompanyName "Conreality Ltd."
VIAddVersionKey  Comments "https://sdk.conreality.dev"

InstallDir "$PROGRAMFILES64\Conreality\SDK"

!insertmacro MUI_PAGE_LICENSE "${SDK}/UNLICENSE"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

Section
  SetOutPath $INSTDIR
  WriteUninstaller $INSTDIR\Uninstall.exe
  File README.txt
  File /oname=LICENSE.txt ${SDK}/UNLICENSE
  File /oname=VERSION.txt ${SDK}/VERSION
SectionEnd

Section "Library"
  SetOutPath $INSTDIR
  CreateDirectory $INSTDIR\Libraries
  File /oname=Libraries\conreality.dll ${SDK}/build/windows/x86_64/conreality.dll
  File /oname=Libraries\conreality.lib ${SDK}/build/windows/x86_64/conreality.lib
  File /oname=Libraries\conreality.pdb ${SDK}/build/windows/x86_64/conreality.pdb
  File /oname=Libraries\libconreality.lib ${SDK}/build/windows/x86_64/libconreality.lib
SectionEnd

Section "Examples"
  SetOutPath $INSTDIR
  CreateDirectory $INSTDIR\Examples
SectionEnd

Section "Headers"
  SetOutPath $INSTDIR
  CreateDirectory $INSTDIR\Headers
  File /oname=Headers\conreality.h ${SDK}/c/conreality.h
  File /oname=Headers\conreality.hpp ${SDK}/cpp/conreality.hpp
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
SectionEnd
