module github.com/dalatmilkshop/saas-verdict

go 1.21

# Tell Hugo (and Go modules) to use the local, vendored theme copy instead
# of trying to fetch the theme from GitHub. This prevents CI/build systems
# from failing when they attempt to resolve the theme as a module.
replace github.com/theNewDynamic/gohugo-theme-ananke/v2 => ./themes/ananke
