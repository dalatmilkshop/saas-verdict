# PowerShell script to update redirects.yaml with new affiliate links
# Usage: .\update-redirects.ps1

param(
    [string]$RedirectsFile = "..\data\redirects.yaml"
)

# New affiliate links mapping (from the mapping script output)
$updates = @{
    "sentrypc" = "https://sentrypc.7eer.net/Trial"
    "godlike-host" = "https://godlikehost.sjv.io/host"
    "nordvpn" = "https://nordvpn.sjv.io/coupons"
    "surfshark" = "https://surfshark.sjv.io/event"
    "decodo-smartproxy" = "https://smartproxy.pxf.io/FreeTrial"
    "mysterium-vpn" = "https://mysteriumvpn.pxf.io/Trial"
    "token-metrics" = "https://tokenmetrics.sjv.io/Trial"
    "martinic-audio" = "https://martinic.evyy.net/trial"
    "spanel" = "https://imp.scalahosting.com/trial"
    "bdthemes-element-pack" = "https://elementpackpro.sjv.io/trial"
    "box" = "https://metabox.sjv.io/trail"
    "aofit" = "https://aofit.pxf.io/trial"
    "coohom" = "https://coohom.pxf.io/trial"
    "tidio" = "https://tidio.pxf.io/trial"
    "clawcloud-singapore" = "https://clawcloudsingaporeprivatelimited.sjv.io/trial"
    "coinrule" = "https://coinrule.sjv.io/trial"
    "bitdefender" = "https://bitdefender.f9tmep.net/trial"
    "technitya" = "https://technitya.sjv.io/trial"
    "kittl" = "https://kittl.pxf.io/trial"
    "zonli" = "https://zonlipartnershipprogram.pxf.io/trial"
    "jalbum" = "https://jalbum-affiliate-program.sjv.io/trial"
    "homestyler" = "https://homestyler.sjv.io/trial"
    "vidranya-social-scheduler" = "https://vidranya.sjv.io/trial"
    "linner-otc-hearing-aids" = "https://ephamedtechinc.pxf.io/trial"
    "electronicx" = "https://electronicx.pxf.io/trial"
    "endoca" = "https://imp.i110150.net/trial"
    "kkday-australia" = "https://kkday.sjv.io/trial"
    "dhgate" = "https://dhgate.sjv.io/trial"
    "slider-revolution" = "https://themepunch.pxf.io/trial"
    "cowinaudio" = "https://cowinaudio.pxf.io/trials"
    "oneplus-fr" = "https://oneplusfr.sjv.io/trial"
    "oral-b-uk" = "https://oralbuk.sjv.io/6e2J5r"
    "oral-b-de" = "https://oralbde.sjv.io/Y9WJxR"
    "oral-b-nl" = "https://oralbnl.pxf.io/DKD2rn"
    "muc-off" = "https://mucoff.sjv.io/jrKvg5"
    "review-au" = "https://review-au.sjv.io/rQj7x3"
    "prop-money-inc" = "https://propmoneyinc.pxf.io/5gOV3N"
    "kikoff" = "https://kikoff.pxf.io/VmoGWE"
    "soulight" = "https://bestpsychiclab.pxf.io/g1y2V9"
    "flowerchimp" = "https://flowerchimp.pxf.io/0Z0e7J"
    "cakerush" = "https://cakerush.sjv.io/21nAqQ"
    "lvly-sea" = "https://getlyla.pxf.io/vNe73j"
    "braun-de" = "https://braungermany.pxf.io/KjkDL9"
    "fitville" = "https://thefitville.pxf.io/jrKv30"
    "dymocks-books-gifts" = "https://dymocks-australia.pxf.io/GmrvNm"
    "vida-glow-au" = "https://vida-glow-au.pxf.io/NkArqV"
    "vida-glow-us" = "https://vida-glow-us.pxf.io/QyV5Qo"
    "printrendy" = "https://printrendy.pxf.io/Y9WJzO"
    "bluetti-eu" = "https://bluettieu.pxf.io/jrKvbn"
    "bluetti-de" = "https://bluettide.pxf.io/AWLbZR"
    "bluetti-it" = "https://bluettiit.sjv.io/B0q6g9"
    "silver-cuisine" = "https://silver-cuisine.pxf.io/4P6191"
    "bluetti-es" = "https://bluetties.sjv.io/Py1PMq"
    "funwhole" = "https://funwhole.sjv.io/g1y2x0"
    "vapordna" = "https://vapordna.pxf.io/m5x7YZ"
    "bluetti-fr" = "https://bluettifr.pxf.io/4P614G"
    "bluetti-us" = "https://bluettius.sjv.io/jrKvqa"
    "ancheer" = "https://ancheer.sjv.io/1rEm46"
    "malaysia-healthcare-travel-council" = "https://malaysia-healthcare-travel-council.pxf.io/4P611L"
    "eimmie" = "https://eimmie.pxf.io/9gvXXY"
    "pish-posh-baby" = "https://pish-posh-baby.sjv.io/zN17Ex"
    "toke-n-dab" = "https://toke-n-dab.pxf.io/XYzVPG"
    "sand-and-sky" = "https://sand-and-sky.sjv.io/21nAP0"
    "natural-cycles" = "https://natural-cycles.sjv.io/LXeQvV"
    "eufy-nl-ca" = "https://eufy.sjv.io/QyV5B6"
    "make" = "https://ankermake.sjv.io/AWLbra"
    "soundcore" = "https://soundcore.sjv.io/zN17WG"
    "puzzle-ready" = "https://puzzlereadyaffiliateprogram.pxf.io/Mma9Pn"
    "happy-sinks-eu" = "https://happy-sinks-eu.sjv.io/jrKvNZ"
    "hemp-bombs" = "https://hempbombs.pxf.io/rQjvPj"
    "aor-canada" = "https://aor.hbbswr.net/AWLz6K"
    "luvme-hair" = "https://luvmehair.sjv.io/ZQ0kWK"
    "trafft" = "https://trafft.pxf.io/nLDOdV"
    "tms-plugins" = "https://tms-plugins.sjv.io/vNeLd3"
    "kkday-singapore" = "https://kkdaysg.pxf.io/ZQ0kaK"
    "brother-usa" = "https://brother.pxf.io/EKQnBW"
    "indo-trick-scooter" = "https://indo-tricks-scooter.sjv.io/OrGNqZ"
    "coach-soak" = "https://coach-soak.sjv.io/da4XBW"
    "bodyotics" = "https://bodyotics.sjv.io/m5x6M7"
    "mushroom-supplies" = "https://mushroom-supplies.sjv.io/jrKEbM"
    "fofana" = "https://fofana.sjv.io/DKDEvb"
    "hoto" = "https://hototools.sjv.io/k0LnxV"
    "kollyy" = "https://kollyy.sjv.io/9gv1Kj"
    "penchant-for-pleasure" = "https://penchant-for-pleasure.sjv.io/Vmor1M"
    "striking-viking" = "https://viking-beard-gear.pxf.io/4P6k1r"
    "mioeco" = "https://mioeco.sjv.io/NkAdrb"
    "atezr" = "https://atezr.pxf.io/q4rR7N"
    "pure-scentum" = "https://pure-scentum.pxf.io/9gv1Xj"
    "hieno-supplies" = "https://hieno-supplies.sjv.io/jrKEv6"
    "ontaki" = "https://ontaki.pxf.io/QyVqoM"
    "asebbo" = "https://asebbo.pxf.io/rQjvZ5"
    "byre-group" = "https://byre-group.pxf.io/k0Lnen"
    "hana-emi" = "https://hana-emi.pxf.io/1rEj0a"
    "twopages" = "https://twopages.pxf.io/g1yzZO"
    "oral-b-it" = "https://oralbit.sjv.io/EKQnoe"
    "nudco" = "https://nudco.pxf.io/R5Jxva"
    "cloudfield" = "https://cloudfield.pxf.io/Mma463"
    "gafly" = "https://gafly.pxf.io/LXevbL"
    "silginnes" = "https://silginnes.sjv.io/rQjv65"
    "throwback-traits" = "https://throwback-traits.pxf.io/an3Jab"
    "bondi-sands-australia" = "https://bondi-sands-australia.pxf.io/NkAgQN"
    "tinyland" = "https://tinyland.pxf.io/q4r1EO"
    "aligrace-hair" = "https://aligracehair.sjv.io/oqQAXY"
    "wowangel" = "https://wowangel.sjv.io/KjkVZz"
    "acebeam-flashlight" = "https://acebeamflashlight.sjv.io/LXeJZO"
    "aidot-smart-living" = "https://aidotcom.pxf.io/LXeJZ3"
    "aidot-uk" = "https://ukaidot.sjv.io/DKD5kG"
    "cheese-credit-builder" = "https://cheesecreditbuilder.sjv.io/rQjV2d"
    "dreame-us" = "https://dreame.sjv.io/AWLrEJ"
    "seafolly-australia" = "https://seafollyaustralia.pxf.io/zN1W4x"
    "mindmanager" = "https://mindmanager.sjv.io/6e2vEE"
    "angashion" = "https://angashion.pxf.io/y2GzkB"
    "iron-bull-strength" = "https://ironbullstrength.pxf.io/DKD53G"
    "ulike-uk" = "https://ukulike.sjv.io/VmonNJ"
    "ulike-us" = "https://usulike.sjv.io/rQjVDd"
    "twotrees-3d" = "https://twotrees3dofficial.sjv.io/k0L5Z0"
    "onemile" = "https://onemilebike.sjv.io/R5JzmX"
    "aoseed" = "https://aoseed.sjv.io/OrGXor"
    "versadesk" = "https://versadesk.pxf.io/rQjVey"
    "paris-rhone" = "https://parisrhonecom.sjv.io/R5JzaR"
    "aspiron" = "https://aspironcom.sjv.io/q4r1NN"
    "love-and-pebble" = "https://lovepebble.sjv.io/B0qj1x"
    "major-fitness" = "https://majorfitness.sjv.io/4P63qM"
    "oral-b-fr" = "https://oralbfr.sjv.io/an3y4b"
    "emeet" = "https://emeetcom.pxf.io/R5JzEa"
    "luxury-toy-x" = "https://lstx.sjv.io/q4r1o5"
    "oral-b-es" = "https://oralbes.pxf.io/oqQAab"
    "protea-hair" = "https://proteahair.pxf.io/NkAgY7"
    "turtle-beach-us" = "https://turtlebeachus.sjv.io/LXeJYj"
    "turtle-beach-uk" = "https://TurtleBeachUK.sjv.io/DKD5Mj"
    "turtle-beach-eu" = "https://turtlebeacheu.sjv.io/0Z0b5V"
    "victory-tailgate" = "https://victorytailgate.pxf.io/vNeXve"
    "beautikini" = "https://beautikini.sjv.io/NkAgyK"
    "open-goaaal" = "https://opengoaaal.sjv.io/9gvNdy"
    "angles90" = "https://angles90.sjv.io/an3yGZ"
    "lux" = "https://lux.sjv.io/B0qjdL"
    "charlemange" = "https://charlemange.pxf.io/k0L5dM"
    "baby-sunnies" = "https://babysunnies.pxf.io/ZQ02WR"
    "unitree-robotics" = "https://unitreerobotics.pxf.io/EKQkDX"
    "amotopart-fairing-creator" = "https://autocreatorrecruitment.sjv.io/Y9WOzO"
    "egohome-mattress" = "https://mlilyusainc.pxf.io/rQjVMB"
    "flat-io" = "https://tutteo.pxf.io/B0qjg4"
    "helmsman-crystal" = "https://helmsmancrystal.sjv.io/0Z006Y"
    "thinkcar" = "https://thinkcar.sjv.io/4P667L"
    "smile-makers-collection" = "https://smilemakers.pxf.io/q4rrKq"
    "mfi-medical" = "https://mfimedical.sjv.io/QyVV99"
    "trinka-ai" = "https://trinkaai.pxf.io/jrKK7b"
    "reemo-innovation" = "https://mowrator.pxf.io/eKdd06"
    "esimx" = "https://skylarkconnectllc.pxf.io/DKDD65"
    "soax" = "https://soax.sjv.io/eKOvbQ"
    "pyproxy" = "https://pyproxy.sjv.io/trials"
    "luxury-escapes" = "https://luxuryescapes.sjv.io/xk0naR"
    "iproyal" = "https://iproyal.sjv.io/GK7Pv6"
    "2brightsparks" = "https://affiliate2brightsparks.evyy.net/XmJ1jX"
    "angelvpn" = "https://angelvpn.sjv.io/RGeRqN"
    "arkuda-digital" = "https://arkmc.pxf.io/dO6Rgj"
    "automattic" = "https://automattic.pxf.io/K0QxmN"
    "braun-it" = "https://braunit.sjv.io/194bY9"
    "capcut" = "https://capcutaffiliateprogram.pxf.io/Vx14kO"
    "cashgamer" = "https://bigcashapp.pxf.io/JKDq6q"
    "clean-email" = "https://cleanemailr.pxf.io/gO3onA"
    "emakpato-digital-art" = "https://emakpatodigitalartphotographyandpainting.sjv.io/zxJjKr"
    "humble-bundle" = "https://humblebundleinc.sjv.io/6y4G6q"
    "inspiration-affiliate" = "https://inspirationaffiliateprogramme.sjv.io/OeP1DW"
    "intellectia-ai" = "https://intellectia.sjv.io/3J47KM"
    "joyoshare" = "https://joyoshare.pxf.io/vPA2Kv"
    "krisp" = "https://krisp.pxf.io/4G4d7n"
    "lenovo-india" = "https://lenovo-in.zlvv.net/dO6RWj"
    "lightailing" = "https://lightailing.sjv.io/N9jNxV"
    "winzip" = "https://winzip.sjv.io/YRZdAP"
    "video-editing-program" = "https://videoeditingprogram.pxf.io/K0Qx6N"
    "ursime" = "https://ursime.pxf.io/7aYb6g"
    "uperfect" = "https://uperfect.sjv.io/LK9DLM"
    "underground-printing" = "https://imp.i357552.net/xL1nK1"
}

# Function to update redirects file
function Update-RedirectsFile {
    param([string]$FilePath, [hashtable]$Updates)

    try {
        # Read current content
        $content = Get-Content $FilePath -Raw

        # Parse existing redirects
        $redirects = @{}
        $lines = $content -split "`n"
        foreach ($line in $lines) {
            if ($line -match '^(\w+[^:]*):\s*(.+)$') {
                $slug = $matches[1].Trim()
                $url = $matches[2].Trim()
                $redirects[$slug] = $url
            }
        }

        # Update with new links
        $updated = 0
        foreach ($slug in $updates.Keys) {
            if ($redirects.ContainsKey($slug)) {
                $oldUrl = $redirects[$slug]
                $newUrl = $updates[$slug]
                if ($oldUrl -ne $newUrl) {
                    $redirects[$slug] = $newUrl
                    $updated++
                    Write-Host "Updated: $slug" -ForegroundColor Green
                    Write-Host "  Old: $oldUrl" -ForegroundColor Gray
                    Write-Host "  New: $newUrl" -ForegroundColor Cyan
                }
            } else {
                Write-Host "Slug not found: $slug" -ForegroundColor Yellow
            }
        }

        # Write back to file
        $newContent = ""
        foreach ($slug in ($redirects.Keys | Sort-Object)) {
            $newContent += "$slug`: $($redirects[$slug])`n"
        }

        $newContent | Set-Content -Path $FilePath -Encoding UTF8

        Write-Host ""
        Write-Host "=== UPDATE SUMMARY ===" -ForegroundColor Cyan
        Write-Host "Total redirects: $($redirects.Count)" -ForegroundColor White
        Write-Host "Updated: $updated" -ForegroundColor Green
        Write-Host "File updated: $FilePath" -ForegroundColor Green

    } catch {
        Write-Host "Error updating redirects file: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
}

# Run the update
Update-RedirectsFile -FilePath (Join-Path $PSScriptRoot $RedirectsFile) -Updates $updates