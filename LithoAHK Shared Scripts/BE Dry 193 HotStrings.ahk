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

; <IndexCmt> <b>Dry 193 Contact Layer Owners</b>
:*:\\Dry193Email::ltd.litho.bedry193.layers@intel.com
:*:\\Dry193MetalPager::DRY193METALLAYER@RF3.INTEL.COM
:*:\\Dry193Metal2Pager::SHIFT1_DRY193_MT_LAYER_2@RF3.INTEL.COM
:*:\\Dry193MetalName::Dry193 Metal Layer
:*:\\Dry193ViaPager::DRY193VIALAYER@RF3.INTEL.COM
:*:\\Dry193Via2Pager::SHIFT1_DRY193_VA_LAYER_2@RF3.INTEL.COM
:*:\\Dry193ViaName::Dry193 Via Layer
:*:\\Dry193TFRPager::DRY193TFRLAYER@RF3.INTEL.COM
:*:\\Dry193TFRName::Dry193 TFR Layer
:*:\\Dry193BKRPager::DRY193_BKR_LAYER@RF3.INTEL.COM
:*:\\Dry193BKRName::Dry193_BKR_layer
:*:\\Dry193MA0Pager::DRY193MA0LAYER@RF3.INTEL.COM
:*:\\Dry193MA0Name::Dry193 MA0 Layer

/*
  Group Specific HotStrings
*/

; <IndexCmt> <b>BE Dry 193 Standard Instructions</b>
:*?:\\EfDispoInst::After measurement: Do not sign off SIF. Layer owner to provide final dispo. Layer owner will be automatically notified through the SIF_DISPO_CONTACT field. ; Real-time dispo EF (put LO or non-Sh1 pager in SIF_DISPO_CONTACT)
:*?:\\EfXqualInst::When processing is complete, FLR the lot. In rework loop, delete all SIFs. Also, comment at SED to "run POR with LCA:SKIP if needed." ; xqual EF reworking to open tools
:*?:\\EfReclInst::After measurement: Do not sign off SIF. TRST to PTBD. Layer owner to provide final dispo. ; NPI targeting RECL EF
:*?:\\NpiContainmentInst::Ok to signoff instructions and run after the scout [lead scout lot] has gone through this layer for DCCD and REG ; Containment for NPI lead lot at SED
:*?:\\NikonGridInst::Regardless of SPC decision, page P1276 Nikon 193nm Scanner GCM duty pager to review data/update scanner_grid table partitions and disposition overlay data. ; SNE grid update signout instructions
:*?:\\MA0GridInst::This dense SIF is for MA0 inverted grid. Regardless of SPC decision, page P1276 Nikon 193nm Scanner GCM duty pager to evaluate grid and update scanner_grid table partitions. ; MA0 inverted grid update instruction
