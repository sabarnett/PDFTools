#!/bin/zsh
setopt NOGLOB

cd "/Users/stevenbarnett/Documents/Code Files/Apps/Frameworks/PDFGenerator/PDFTools/"

scheme="PDFTools"

destinations=("generic/platform=iOS" 
			  "generic/platform=iOS Simulator")
			  
archives=("./build/$scheme.framework-iphoneos.xcarchive" 
		  "./build/$scheme.framework-iphonesimulator.xcarchive")

frameworks=("./build/$scheme.framework-iphoneos.xcarchive/Products/Library/Frameworks/$scheme.framework"
			"./build/$scheme.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/$scheme.framework")

xcframework="./build/$scheme.xcframework"

# ----------------------------------------------------------------------
#
# This is the build process. It is driven by the above variables
#
# ----------------------------------------------------------------------

length=${#destinations[@]}
for (( ix=1; ix<=length; ix++ ));
do
   #
   # Clean the target project and remove any previously generated archive
   #
   echo "Clean ${destinations[$ix]}"
   xcodebuild clean \
   -scheme $scheme \
   -destination "${destinations[$ix]}" \
   -configuration Debug \
   -quiet

   rm -r "${archives[$ix]}"
   
   #
   # Rebuild the framework first
   #
   echo "Build the framework for ${destinations[$ix]}"

   xcodebuild archive \
   -scheme $scheme \
   -configuration Release \
   -destination "${destinations[$ix]}" \
   -archivePath "${archives[$ix]}" \
   -quiet \
   SKIP_INSTALL=NO \
   BUILD_LIBRARY_FOR_DISTRIBUTION=YES

   #
   # Then rebuild the documentation
   #
   echo "Build documentation for ${destinations[$ix]}"

   xcodebuild docbuild \
   -scheme $scheme \
   -destination "${destinations[$ix]}" \
   -quiet

done

#
# Now that the framework archives have been built, create the xcframework
#
# Note, we are building a parameter list for xcodebuild and the parameters will
# contain spaces. So, we cannot use string concatenation or zsh will surround the
# resulting string with quotes. The only legitimate way to get round this is to
# build an array of  command line options and unwrap that.
echo '*** Delete xcframework and rebuild'
rm -r "${xcframework}"

params=("-create-xcframework")
for fwk in "${frameworks[@]}"
do
	params+=("-framework" "${fwk}")
done
params+=("-output" "${xcframework}")

xcodebuild ${params[@]}
