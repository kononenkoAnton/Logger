# Logger


1. download http://s.sudre.free.fr/Software/Packages/about.html
2. archive the app, notarize, save notarized app file to some location
3. add the notarized app file to the Applications folder
4. build the package
5. sign the package with developer id installer certificate
6. /usr/bin/productsign --sign "Developer ID Installer: Applicaster Ltd. (WZZ4E5L8EL)" //Logger.pkg //Logger-Signed.pkg
7. check signature
   pkgutil --check-signature /Logger-Signed.pkg
8. notarization for the package
   xcrun altool --notarize-app --primary-bundle-id "com.applicaster.logger" /Logger-Signed.pkg --username “APPLE ID” --password “<APP_SPECIFIC_PASS>” --asc-provider WZZ4E5L8EL
9. wait for email of notarization complete (+- 2 min)
10. check notarization (not needed if email arrived)
11. xcrun altool --notarization-history 0 -u “APPLE ID” -p “<APP_SPECIFIC_PASS>” --asc-provider WZZ4E5L8EL
12. finalize with stapler
    xcrun stapler staple /Logger-Signed.pkg
