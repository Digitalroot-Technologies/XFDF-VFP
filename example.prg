DEFINE CLASS Test AS Custom OLEPublic
    _sErrorMessage = ""

    FUNCTION GetName() as Integer
        SET PROCEDURE to XFDFCLASS
        WITH this
            oPDF = CreateObject("XFDF", "https://localhost/PDF/CA227/CA227.pdf")
            oPDF.AddValue('VIN', "123456789")
            oPDF.setPathToPDF('http://testserver/Other/CA227/CA227.pdf') && Debugging
            oPDF.PrintToScreen()
            RETURN 0
        ENDWITH
    ENDFUNC
    
    FUNCTION getErrorMessage as String
        RETURN this._sErrorMessage
    ENDFUNC

ENDDEFINE

