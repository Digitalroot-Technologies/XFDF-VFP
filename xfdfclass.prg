***
 * This class definition is used to create PDF files using the XFDF format.
 *
 * @author Nicholas Dunnaway
 *
 */

***
 * XFDF Class
 *
 */
DEFINE Class XFDF AS Custom

    ***
     * This is the path to the PDF file that adobe will load.
     *
     * @var string
     */
        PathToPDF = ""

    ***
     * This is the Content-type Header that tells 
     * the browser what type of file this is.
     *
     * @var string
     */
    HeaderContentType = "Content-type: application/vnd.adobe.xfdf" + Chr(13) + Chr(10) 

    ***
     * This is the Content-Length Header that tells 
     * the browser how big the file is. IE will not
     * display the file without this.
     *
     * @var string
     */
    HeaderContentLength = "Content-Length: " 

    ***
     * This hold the XML that starts the XFDF file.
     *
     * @var string
     */
    XMLHeader = ""

    ***
     * This holds the XML that the user passes with addValue.
     *
     * @var string
     */
    XMLBody = ""

    ***
     * This holds the XML that ends/closes the XFDF file.
     *
     * @var string
     */
    XMLFooter = ""

    ***
     * The Constructor
     *
     * @param string PathToPDF
     */
    FUNCTION init (PathToPDF)
        LOCAL PathToPDF
        WITH this
            .setPathToPDF(PathToPDF)
            ._setXMLFooter()
        ENDWITH
    ENDFUNC

    ***
     * This builds the XML Footer.
     *
     *  This is an internal method. Do not use.
     */
    FUNCTION _setXMLFooter()
        WITH this
            .XMLFooter = '</fields>' + Chr(13) + Chr(10)
            .XMLFooter = .XMLFooter + '</xfdf>' + Chr(13) + Chr(10)
        ENDWITH
    ENDFUNC

    ***
     * This builds the XML header.
     *
     *  This is an internal method. Do not use.
     */
    FUNCTION _setXMLHeader()
        WITH this
            .XMLHeader = '<?xml version="1.0" encoding="UTF-8"?>' + Chr(13) + Chr(10)
            .XMLHeader = .XMLHeader + '<xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">' + Chr(13) + Chr(10)
            .XMLHeader = .XMLHeader + '<f href="' + .PathToPDF + '"/>' + Chr(13) + Chr(10)
            .XMLHeader = .XMLHeader + '<ids original="7A0631678ED475F0898815F0A818CFA1" modified="BEF7724317B311718E8675B677EF9B4E"/>' + Chr(13) + Chr(10)
            .XMLHeader = .XMLHeader + '<fields>' + Chr(13) + Chr(10)
        ENDWITH
    ENDFUNC

    ***
     * This adds a field and value to the PDF. 
     * This is used to auto populate fields.
     *
     * @param string sField
     * @param string sValue
     */
    FUNCTION addValue(sField, sValue)
        LOCAL sField, sValue
        WITH this
            .XMLBody = .XMLBody + '<field name="' +  sField + '">' + Chr(13) + Chr(10)
            .XMLBody = .XMLBody + '<value>' + sValue + '</value>' + Chr(13) + Chr(10)
            .XMLBody = .XMLBody + '</field>' + Chr(13) + Chr(10)
        ENDWITH
    ENDFUNC

    ***
     * Returns the path to the PDF file.
     *
     * @return string
     */
    FUNCTION getPathToPDF()
        RETURN this.PathToPDF
    ENDFUNC

    ***
     * Returns the content of the XFDF file with out headers. 
     * This can be used to store the data in a database.
     *
     * @return string
     */
    FUNCTION getXML()
        LOCAL thisReturns
        WITH this
            thisReturns = .XMLHeader
            thisReturns = thisReturns + .XMLBody
            thisReturns = thisReturns + .XMLFooter
        ENDWITH
        RETURN thisReturns
    ENDFUNC

    ***
     * Returns the content of the XFDF file with headers. 
     * This can be used to display to the browser.
     *
     * @return string
     */
    FUNCTION PrintToScreen()
        LOCAL thisReturns
        WITH this
            thisReturns = .HeaderContentType
            thisReturns = thisReturns + .HeaderContentLength + ALLTRIM(STR(LEN(.getXML()))) + Chr(13) + Chr(10) + Chr(13) + Chr(10)
            thisReturns = thisReturns + .getXML()
        ENDWITH
        RETURN thisReturns
    ENDFUNC

    ***
     * Sets the path to the PDF file adobe will load.
     *
     * @param string PathToPDF
     */
    FUNCTION setPathToPDF(PathToPDF)
        LOCAL PathToPDF
        WITH this
            .PathToPDF = PathToPDF
            ._setXMLHeader()
        ENDWITH
    ENDFUNC

ENDDEFINE
