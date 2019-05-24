try {$AuthToken = Get-content imgur.authtoken -ErrorAction Stop}
catch {
    Write-Output "Auth token not found.  Create file imgur.authtoken with auth token inside."
    exit
}

$CatURL = "https://cdn.vox-cdn.com/thumbor/j-AiZGm4WQP1XmpeWk05_rk4HEs=/0x0:3000x2000/1200x800/filters:focal(1032x224:1512x704)/cdn.vox-cdn.com/uploads/chorus_image/image/63214701/miles_captain_marvel_cat_marvel_ringer.0.jpg"

# If using PSCore 6, Invoke-RestMethod has been updated with an -Authentication paramter which can replace manually specifying the Header info, e.g. -Authentication oauth -token <token>
$PostCat = Invoke-RestMethod -uri https://api.imgur.com/3/upload -Method post -Headers @{"Authorization" = "Bearer $AuthToken"} -Body $CatURL

start $PostCat.data.link