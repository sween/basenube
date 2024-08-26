Class Coruscant.InterSystems.FHIR
{

ClassMethod Setup() As %Status
{
    zn "HSLIB"
    Set appKey = "/intersystems/fhir/r5"
    Set strategyClass = "HS.FHIRServer.Storage.JsonAdvSQL.InteractionsStrategy"
    Set metadataPackages = $lb("hl7.fhir.r5.core@5.0.0")

    //Install a Foundation namespace and change to it
    Do ##class(HS.Util.Installer.Foundation).Install("USER")
    Set $namespace = "USER"

    // Install elements that are required for a FHIR-enabled namespace
    Do ##class(HS.FHIRServer.Installer).InstallNamespace()

    // Install an instance of a FHIR Service into the current namespace
    Do ##class(HS.FHIRServer.Installer).InstallInstance(appKey, strategyClass, metadataPackages)

    //Get and modify FHIR server's configuration object
    Set strategy = ##class(HS.FHIRServer.API.InteractionsStrategy).GetStrategyForEndpoint(appKey)
    Set configData = strategy.GetServiceConfigData()
    Set configData.DefaultPreferHandling = "strict"
    Set configData.DebugMode = 5
    Set enabled = 1
    Set serviceConfigName = "HS.InteropPackage.myBusinessService"
    Set oAuthClient = "OAuthClientName"
    //stringify configData before updating FHIR Server
    Set jsonConfigData = configData.AsJSONString()
    
    // Update FHIR Server
    Do ##class(HS.FHIRServer.Installer).UpdateInstance(appKey, jsonConfigData, enabled,serviceConfigName)

}


}