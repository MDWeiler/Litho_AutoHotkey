#SingleInstance force ; Automatically replace any instance of this script already running
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input ; Recommended for new scripts due to its superior speed and reliability
; SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory -- This is not helpful when loading from a Shared Location
#IfWinActive ; Used to prevent any of the following
;    scripts from being window specific due to previous code
; #Warn                      ; Enable to see warnings to help detect common errors

/*
    Auto Correction Syntax (Called Hotstrings in the manual)
      :[Options]:[What You Type]::[What to Replace it with]
	  Options: (common)
		* - Removes the need for an end character before the HotSting fires
		b0 - prevents the backspacing that clears the HotString
        ? - Allow within word replacements (:*?:al::line would replace the al in cal with line resulting in cline)
      Special Characters need to be wrapped in {} to use normally Example: Hello World{!}
        ! - Alt Key
        + - Shift Key
        ^ - Ctrl
        # - Window Key
        { and } - Escape braces
      Extra Special Characters when using Transform
        % needs to be escaped with `` --> ``%
        ` needs to be double escaped --> ````
*/

/*
	Email and Pager
*/

; <IndexCmt> <b>D1 Litho 1222 Wet Layer Owners</b>
:*:\\22wetLayerOwnersEmail::D1 Litho 1222 Wet Layer Owners
:*:\\22wetLayerOwnersAemail::D1.Litho.1222.Wet.Layer.Owners@intel.com

; <IndexCmt> <b>p1222 Back End Immersion Layer Owners</b>
:*:\\22BEwetEmail::D1 Litho 1222 Wet VA Layer Owners
:*:\\22BEwetAemail::D1.Litho.1222.Wet.VA.Layer.Owners@Intel.com
:*:\\22BEwetPager::Litho 1222 BE Wet Layer
:*:\\22BEwetAPager::Litho1222BEWetLayer@RF3.Intel.com
:*:\\22BEwetOnCallPager::Litho 1222 BE Wet Layer OnCall
:*:\\22BEwetOnCallAPager::Litho1222BEWetLayerOnCall@RF3.Intel.com

; <IndexCmt> <b>Layer ETs</b>
:*:\\LayerETpager::Litho Patterning ET
:*:\\LayerETaPager::LithoPatterningET@RF3.Intel.com
:*:\\LayerETemail::LTD Litho Process MET
:*:\\LayerETaEmail::LTD.Litho.Process.MET@Intel.com
:*:\\Shift4LayerETemail::LTD Litho Process MET S4
:*:\\Shift4LayerETaEmail::LTD.Litho.Process.MET.S4@Intel.com

; <IndexCmt> <b>p1222 FE Immersion Layer Owners</b>
:*:\\22FCCemail::D1 Litho 1222 Fin Cut Con Layer Owners
:*:\\22FCCaEmail::D1.Litho.1222.Fin.Cut.Con.Layer.Owners@Intel.com
; -- OLD :*:\\22FCCpager::Litho 1222 DCB-DNx-PCx-T1x-GCx Layer
; -- OLD :*:\\22FCCaPager::Litho1222DCB-DNx-PCx-T1x-GCxLayer@RF3.Intel.com
:*:\\s1FCCpager::1222-74-75 FE Immersion S1 Oncall
:*:\\s1FCCaPager::1222-74-75FEimmersionS1OnCall@RF3.Intel.com

; <IndexCmt> <b>Litho 1222 M2-6 Layer (Pager Only)</b>
:*:\\22MTxPager::Litho 1222 M2-6 Layer
:*:\\22MTxAPager::Litho1222M2-6Layer@RF3.Intel.com

; <IndexCmt> <b>p1274-75 FE Immersion Layer Owners</b>
:*:\\74FCCeMail::D1 Litho 1274 FE Immersion Layers
:*:\\74FCCAeMail::D1.Litho.1274.FE.Immersion.Layers@Intel.com
; -- OLD :*:\\74FCCpager::Litho 1274-75 DCB-DNx-PCx-FTI-TPx Layer
; -- OLD :*:\\74FCCaPager::Litho1274-75DCB-DNx-PCx-FTI-TPxLayer@RF3.Intel.com

; <IndexCmt> <b>p1222-p1276 Pre-Poly Dry Nikon ACE Layers</b>
:*:\\s1ACEpager::FE Dry ACE S1 Oncall
:*:\\s1ACEaPager::FEdryACEs1OnCall@RF3.Intel.com

; <IndexCmt> <b>p1276 Front End Immersion and EUV Layers</b>
:*:\\76ImmEmail::LTD-M Litho Layers 1276 FE
:*:\\76ImmAeMail::ltd-m.litho.layers.1276.fe@intel.com
:*:\\s176ImmPager::1276 FE Immersion Layers S1 Oncall
:*:\\s176ImmApager::1276FEIMMERSIONLAYERSS1ONCALL@RF3.INTEL.COM
:*:\\76EUVeMail::LTD-M Litho Layers 1276 FE
:*:\\76EUVaEmail::ltd-m.litho.layers.1276.fe@intel.com
:*:\\s176EUVpager::1276 FE EUV Layers S1 Oncall
:*:\\s176EUVaPager::1276FEEUVLAYERSS1ONCALL@RF3.INTEL.COM
 
; <IndexCmt> <b>CWW Eng Pagers</b>
:*:\\cwwFCCpager::Litho 1222-74-75 FE Immersion Layer CWW
:*:\\cwwFCCaPager::Litho1222-74-75FEimmersionLayerCWW@RF3.Intel.com
:*:\\cwwACEpager::p1222/74/75/76/77 FE Dry ACE
:*:\\cwwACEaPager::p122274757677FEdryACE@RF3.Intel.com
:*:\\cww76ImmPager::LTD-M Litho Layers 1276 FE Immersion
:*:\\cww76ImmApager::LTD-MlithoLayers1276FEimmersion@RF3.Intel.com
:*:\\cww76EUVpager::LTD-M Litho Layers 1276 FE EUV
:*:\\cww76EUVaPager::LTD-MlithoLayers1276FEeuv@RF3.Intel.com
