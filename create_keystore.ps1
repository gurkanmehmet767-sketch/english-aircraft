$keytoolPath = 'C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe'
& $keytoolPath -genkey -v -keystore android/app/upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload -storepass 'EnglishAircraft2025!' -keypass 'EnglishAircraft2025!' -dname 'CN=English Aircraft, OU=Mobile Development, O=English Aircraft, L=Istanbul, ST=Istanbul, C=TR'
