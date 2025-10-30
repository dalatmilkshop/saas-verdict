# PowerShell script to map new affiliate links to existing slugs
# Usage: .\map-affiliate-links.ps1

param(
    [string]$RedirectsFile = "..\data\redirects.yaml"
)

# New affiliate links provided by user
$newLinks = @(
    "https://sentrypc.7eer.net/Trial",
    "https://godlikehost.sjv.io/host",
    "https://nordvpn.sjv.io/coupons",
    "https://surfshark.sjv.io/event",
    "https://smartproxy.pxf.io/FreeTrial",
    "https://mysteriumvpn.pxf.io/Trial",
    "https://tokenmetrics.sjv.io/Trial",
    "https://martinic.evyy.net/trial",
    "https://imp.scalahosting.com/trial",
    "https://elementpackpro.sjv.io/trial",
    "https://metabox.sjv.io/trail",
    "https://aofit.pxf.io/trial",
    "https://coohom.pxf.io/trial",
    "https://tidio.pxf.io/trial",
    "https://clawcloudsingaporeprivatelimited.sjv.io/trial",
    "https://coinrule.sjv.io/trial",
    "https://bitdefender.f9tmep.net/trial",
    "https://technitya.sjv.io/trial",
    "https://kittl.pxf.io/trial",
    "https://zonlipartnershipprogram.pxf.io/trial",
    "https://jalbum-affiliate-program.sjv.io/trial",
    "https://homestyler.sjv.io/trial",
    "https://vidranya.sjv.io/trial",
    "https://ephamedtechinc.pxf.io/trial",
    "https://electronicx.pxf.io/trial",
    "https://imp.i110150.net/trial",
    "https://kkday.sjv.io/trial",
    "https://dhgate.sjv.io/trial",
    "https://themepunch.pxf.io/trial",
    "https://cowinaudio.pxf.io/trials",
    "https://oneplusfr.sjv.io/trial",
    "https://oralbuk.sjv.io/6e2J5r",
    "https://oralbde.sjv.io/Y9WJxR",
    "https://oralbnl.pxf.io/DKD2rn",
    "https://mucoff.sjv.io/jrKvg5",
    "https://review-au.sjv.io/rQj7x3",
    "https://propmoneyinc.pxf.io/5gOV3N",
    "https://kikoff.pxf.io/VmoGWE",
    "https://bestpsychiclab.pxf.io/g1y2V9",
    "https://flowerchimp.pxf.io/0Z0e7J",
    "https://cakerush.sjv.io/21nAqQ",
    "https://getlyla.pxf.io/vNe73j",
    "https://braungermany.pxf.io/KjkDL9",
    "https://thefitville.pxf.io/jrKv30",
    "https://dymocks-australia.pxf.io/GmrvNm",
    "https://vida-glow-au.pxf.io/NkArqV",
    "https://vida-glow-us.pxf.io/QyV5Qo",
    "https://printrendy.pxf.io/Y9WJzO",
    "https://bluettieu.pxf.io/jrKvbn",
    "https://bluettide.pxf.io/AWLbZR",
    "https://bluettiit.sjv.io/B0q6g9",
    "https://silver-cuisine.pxf.io/4P6191",
    "https://bluetties.sjv.io/Py1PMq",
    "https://funwhole.sjv.io/g1y2x0",
    "https://vapordna.pxf.io/m5x7YZ",
    "https://bluettifr.pxf.io/4P614G",
    "https://bluettius.sjv.io/jrKvqa",
    "https://ancheer.sjv.io/1rEm46",
    "https://malaysia-healthcare-travel-council.pxf.io/4P611L",
    "https://eimmie.pxf.io/9gvXXY",
    "https://pish-posh-baby.sjv.io/zN17Ex",
    "https://toke-n-dab.pxf.io/XYzVPG",
    "https://sand-and-sky.sjv.io/21nAP0",
    "https://natural-cycles.sjv.io/LXeQvV",
    "https://eufy.sjv.io/QyV5B6",
    "https://ankermake.sjv.io/AWLbra",
    "https://soundcore.sjv.io/zN17WG",
    "https://puzzlereadyaffiliateprogram.pxf.io/Mma9Pn",
    "https://happy-sinks-eu.sjv.io/jrKvNZ",
    "https://hempbombs.pxf.io/rQjvPj",
    "https://aor.hbbswr.net/AWLz6K",
    "https://luvmehair.sjv.io/ZQ0kWK",
    "https://trafft.pxf.io/nLDOdV",
    "https://tms-plugins.sjv.io/vNeLd3",
    "https://kkdaysg.pxf.io/ZQ0kaK",
    "https://brother.pxf.io/EKQnBW",
    "https://indo-tricks-scooter.sjv.io/OrGNqZ",
    "https://coach-soak.sjv.io/da4XBW",
    "https://bodyotics.sjv.io/m5x6M7",
    "https://mushroom-supplies.sjv.io/jrKEbM",
    "https://fofana.sjv.io/DKDEvb",
    "https://hototools.sjv.io/k0LnxV",
    "https://kollyy.sjv.io/9gv1Kj",
    "https://penchant-for-pleasure.sjv.io/Vmor1M",
    "https://big-bat-box.pxf.io/6e2aJb",
    "https://viking-beard-gear.pxf.io/4P6k1r",
    "https://mioeco.sjv.io/NkAdrb",
    "https://atezr.pxf.io/q4rR7N",
    "https://pure-scentum.pxf.io/9gv1Xj",
    "https://hieno-supplies.sjv.io/jrKEv6",
    "https://ontaki.pxf.io/QyVqoM",
    "https://asebbo.pxf.io/rQjvZ5",
    "https://byre-group.pxf.io/k0Lnen",
    "https://hana-emi.pxf.io/1rEj0a",
    "https://twopages.pxf.io/g1yzZO",
    "https://oralbit.sjv.io/EKQnoe",
    "https://nudco.pxf.io/R5Jxva",
    "https://cloudfield.pxf.io/Mma463",
    "https://gafly.pxf.io/LXevbL",
    "https://silginnes.sjv.io/rQjv65",
    "https://throwback-traits.pxf.io/an3Jab",
    "https://bondi-sands-australia.pxf.io/NkAgQN",
    "https://tinyland.pxf.io/q4r1EO",
    "https://aligracehair.sjv.io/oqQAXY",
    "https://wowangel.sjv.io/KjkVZz",
    "https://acebeamflashlight.sjv.io/LXeJZO",
    "https://aidotcom.pxf.io/LXeJZ3",
    "https://ukaidot.sjv.io/DKD5kG",
    "https://cheesecreditbuilder.sjv.io/rQjV2d",
    "https://dreame.sjv.io/AWLrEJ",
    "https://seafollyaustralia.pxf.io/zN1W4x",
    "https://mindmanager.sjv.io/6e2vEE",
    "https://angashion.pxf.io/y2GzkB",
    "https://ironbullstrength.pxf.io/DKD53G",
    "https://ukulike.sjv.io/VmonNJ",
    "https://deulike.sjv.io/VmonNJ",
    "https://usulike.sjv.io/rQjVDd",
    "https://twotrees3dofficial.sjv.io/k0L5Z0",
    "https://onemilebike.sjv.io/R5JzmX",
    "https://aoseed.sjv.io/OrGXor",
    "https://versadesk.pxf.io/rQjVey",
    "https://parisrhonecom.sjv.io/R5JzaR",
    "https://aspironcom.sjv.io/q4r1NN",
    "https://lovepebble.sjv.io/B0qj1x",
    "https://majorfitness.sjv.io/4P63qM",
    "https://oralbfr.sjv.io/an3y4b",
    "https://emeetcom.pxf.io/R5JzEa",
    "https://lstx.sjv.io/q4r1o5",
    "https://oralbes.pxf.io/oqQAab",
    "https://proteahair.pxf.io/NkAgY7",
    "https://turtlebeachus.sjv.io/LXeJYj",
    "https://TurtleBeachUK.sjv.io/DKD5Mj",
    "https://turtlebeacheu.sjv.io/0Z0b5V",
    "https://victorytailgate.pxf.io/vNeXve",
    "https://beautikini.sjv.io/NkAgyK",
    "https://opengoaaal.sjv.io/9gvNdy",
    "https://angles90.sjv.io/an3yGZ",
    "https://lux.sjv.io/B0qjdL",
    "https://charlemange.pxf.io/k0L5dM",
    "https://babysunnies.pxf.io/ZQ02WR",
    "https://unitreerobotics.pxf.io/EKQkDX",
    "https://autocreatorrecruitment.sjv.io/Y9WOzO",
    "https://mlilyusainc.pxf.io/rQjVMB",
    "https://tutteo.pxf.io/B0qjg4",
    "https://helmsmancrystal.sjv.io/0Z006Y",
    "https://thinkcar.sjv.io/4P667L",
    "https://smilemakers.pxf.io/q4rrKq",
    "https://mfimedical.sjv.io/QyVV99",
    "https://trinkaai.pxf.io/jrKK7b",
    "https://mowrator.pxf.io/eKdd06",
    "https://skylarkconnectllc.pxf.io/DKDD65",
    "https://soax.sjv.io/eKOvbQ",
    "https://pyproxy.sjv.io/trials",
    "https://luxuryescapes.sjv.io/xk0naR",
    "https://iproyal.sjv.io/GK7Pv6",
    "https://affiliate2brightsparks.evyy.net/XmJ1jX",
    "https://angelvpn.sjv.io/RGeRqN",
    "https://arkmc.pxf.io/dO6Rgj",
    "https://automattic.pxf.io/K0QxmN",
    "https://braunit.sjv.io/194bY9",
    "https://capcutaffiliateprogram.pxf.io/Vx14kO",
    "https://bigcashapp.pxf.io/JKDq6q",
    "https://cleanemailr.pxf.io/gO3onA",
    "https://emakpatodigitalartphotographyandpainting.sjv.io/zxJjKr",
    "https://humblebundleinc.sjv.io/6y4G6q",
    "https://inspirationaffiliateprogramme.sjv.io/OeP1DW",
    "https://intellectia.sjv.io/3J47KM",
    "https://joyoshare.pxf.io/vPA2Kv",
    "https://krisp.pxf.io/4G4d7n",
    "https://lenovo-in.zlvv.net/dO6RWj",
    "https://lightailing.sjv.io/N9jNxV",
    "https://winzip.sjv.io/YRZdAP",
    "https://videoeditingprogram.pxf.io/K0Qx6N",
    "https://ursime.pxf.io/7aYb6g",
    "https://uperfect.sjv.io/LK9DLM",
    "https://imp.i357552.net/xL1nK1"
)

# Function to extract domain/identifier from URL
function Get-UrlIdentifier {
    param([string]$Url)

    # Extract domain and remove common prefixes/suffixes
    $uri = [System.Uri]$Url
    $domain = $uri.Host

    # Remove www. if present
    $domain = $domain -replace '^www\.', ''

    # Remove common TLDs and get the main identifier
    $domain = $domain -replace '\.(com|net|org|io|co|uk|de|fr|it|es|nl|au|sg|in)$', ''

    return $domain.ToLower()
}

# Function to find matching slug for a URL
function Find-MatchingSlug {
    param([string]$Url)

    $urlIdentifier = Get-UrlIdentifier -Url $Url

    # Read existing redirects
    $redirectsPath = Join-Path $PSScriptRoot $RedirectsFile
    $redirectsContent = Get-Content $redirectsPath -Raw

    # Parse YAML (simple parsing for key: value format)
    $redirects = @{}
    $lines = $redirectsContent -split "`n"
    foreach ($line in $lines) {
        if ($line -match '^(\w+[^:]*):\s*(.+)$') {
            $slug = $matches[1].Trim()
            $existingUrl = $matches[2].Trim()
            $redirects[$slug] = $existingUrl
        }
    }

    # Find matching slug based on URL similarity
    foreach ($slug in $redirects.Keys) {
        $existingIdentifier = Get-UrlIdentifier -Url $redirects[$slug]

        # Direct match
        if ($existingIdentifier -eq $urlIdentifier) {
            return $slug
        }

        # Partial match (contains the identifier)
        if ($urlIdentifier.Contains($existingIdentifier) -or $existingIdentifier.Contains($urlIdentifier)) {
            return $slug
        }

        # Special cases for known variations
        $slugNormalized = $slug -replace '[-_]', ''
        $urlNormalized = $urlIdentifier -replace '[-_]', ''

        if ($slugNormalized.Contains($urlNormalized) -or $urlNormalized.Contains($slugNormalized)) {
            return $slug
        }
    }

    return $null
}

# Main function
function Show-AffiliateMapping {
    Write-Host "=== AFFILIATE LINK MAPPING ===" -ForegroundColor Cyan
    Write-Host ""

    $mapped = 0
    $unmapped = 0

    foreach ($link in $newLinks) {
        $matchingSlug = Find-MatchingSlug -Url $link

        if ($matchingSlug) {
            Write-Host "$matchingSlug -> $link" -ForegroundColor Green
            $mapped++
        } else {
            Write-Host "UNMAPPED: $link" -ForegroundColor Yellow
            $unmapped++
        }
    }

    Write-Host ""
    Write-Host "=== SUMMARY ===" -ForegroundColor Cyan
    Write-Host "Mapped: $mapped" -ForegroundColor Green
    Write-Host "Unmapped: $unmapped" -ForegroundColor Yellow
    Write-Host "Total: $($newLinks.Count)" -ForegroundColor White
}

# Run the script
Show-AffiliateMapping