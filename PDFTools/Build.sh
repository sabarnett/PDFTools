cd "/Users/stevenbarnett/Documents/Code Files/Apps/Frameworks/PDFGenerator/PDFTools/"

xcodebuild clean -scheme PDFTools -destination 'generic/platform=iOS' -quiet
xcodebuild clean -scheme PDFTools -destination 'generic/platform=iOS Simulator' -quiet

echo '*** Delete the iphone archive and rebuild'
rm -r './build/PDFTools.framework-iphoneos.xcarchive'

echo 'Build the documentation'
xcodebuild docbuild \
-scheme PDFTools \
-destination 'generic/platform=iOS' \
-quiet

echo 'Build the framework'
xcodebuild archive \
-scheme PDFTools \
-configuration Release \
-destination 'generic/platform=iOS' \
-archivePath './build/PDFTools.framework-iphoneos.xcarchive' \
-quiet \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES 

echo '*** Delete iphone simulator archive and rebuild'
rm -r './build/PDFTools.framework-iphonesimulator.xcarchive'

echo 'Build the documentation'
xcodebuild docbuild \
-scheme PDFTools \
-destination 'generic/platform=iOS Simulator' \
-quiet

echo 'Build the framework'
xcodebuild archive \
-scheme PDFTools \
-configuration Release \
-destination 'generic/platform=iOS Simulator' \
-archivePath './build/PDFTools.framework-iphonesimulator.xcarchive' \
-quiet \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

echo '*** Delete xcframework and rebuild'
rm -r './build/PDFTools.xcframework'

xcodebuild -create-xcframework \
-framework './build/PDFTools.framework-iphoneos.xcarchive/Products/Library/Frameworks/PDFTools.framework' \
-framework './build/PDFTools.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/PDFTools.framework' \
-output './build/PDFTools.xcframework'
