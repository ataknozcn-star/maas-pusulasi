# Maaş Pusulası — Android uygulaması

Maaşınızı sabit giderlere, borca (asgari mi tam mı), günlük harcamaya, acil fona ve yatırıma bölen uygulama.

- **İnternetsiz çalışır.** Bütün hesaplamalar telefonda yapılır, girdiğiniz bilgiler telefonda saklanır.
- **İnternet varken** dolar ve euro kuru TCMB'den alınır. Diğer piyasa verileri `www/market.json` dosyasından gelir.
- **Üyelik (isteğe bağlı):** E-posta ve şifreyle giriş yaparsanız kayıtlarınız buluta da yazılır. Başka bir telefonda aynı hesapla girdiğinizde aynı kayıtları görürsünüz.

---

## Kurulum: adım adım

Her şey ücretsiz. Bilgisayardan yapmak daha kolaydır ama telefondan da olur.

### 1. GitHub hesabı ve depo (APK'yı GitHub derleyecek)

1. https://github.com/signup adresinden ücretsiz hesap açın.
2. https://github.com/new adresine gidin.
   - **Repository name:** `maas-pusulasi`
   - **Public** seçin. Böylece APK derleme süresi sınırsız ve ücretsiz olur. Kişisel bilgileriniz depoda değil, telefonunuzda ve Supabase'te durur.
   - **Create repository** deyin.
3. Bu klasördeki tüm dosyaları depoya yükleyin.
   - Depo sayfasında **"uploading an existing file"** bağlantısına tıklayın.
   - Zip'i açtığınız klasörün **içindekileri** sürükleyip bırakın. Gizli `.github` klasörü de gitmeli.
   - **Commit changes** deyin.
   - Bunu Claude'a da yaptırabilirsiniz. Claude ayarlarından GitHub'ı bağlarsanız dosyaları sizin yerinize depoya gönderebilir.
4. Yükledikten sonra depoda `.github/workflows/build-apk.yml` dosyası görünmüyorsa, gizli klasör yüklenmemiş demektir. O zaman:
   - **Add file → Create new file** deyin.
   - Dosya adı kutusuna `.github/workflows/build-apk.yml` yazın.
   - Zip'teki aynı dosyanın içeriğini kopyalayıp yapıştırın.
   - **Commit changes** deyin.

### 2. APK'yı indirme

1. Dosyalar yüklenince derleme kendiliğinden başlar. Depo sayfasında **Actions** sekmesinden takip edebilirsiniz. Yaklaşık 5–8 dakika sürer.
2. Yeşil tik çıkınca depo ana sayfasında sağdaki **Releases** kısmına girin. Oradan `MaasPusulasi.apk` dosyasını telefonunuza indirin.
3. Dosyayı açın. Android "bilinmeyen kaynak" izni isterse, o seferlik izin verin ve kurun.

Bu adımlardan sonra uygulama internetsiz de çalışır. Üyelik istemiyorsanız burada bitirebilirsiniz.

### 3. Üyelik ve bulut kaydı (isteğe bağlı, Supabase)

1. https://supabase.com adresinden ücretsiz hesap açın. GitHub ile giriş yapabilirsiniz.
2. **New project** deyin.
   - Ad: `maas-pusulasi`
   - Bir veritabanı şifresi belirleyin ve bir yere not edin.
   - Bölge olarak **Central EU (Frankfurt)** seçin.
3. Proje açılınca sol menüden **SQL Editor → New query** yolunu izleyin. `supabase.sql` dosyasının içeriğini yapıştırıp **Run** deyin.
4. Sol menüden **Authentication → Sign In / Providers → Email** yolunu izleyin.
   - **Confirm email** seçeneğini **kapatın**. Kapatmazsanız her yeni hesap için e-posta onayı gerekir ve onay bağlantısı telefonda düzgün açılmaz.
   - Kaydedin.
5. Sol menüden **Project Settings → API** sayfasına girin. Şu iki değeri kopyalayın:
   - **Project URL**. `https://xxxx.supabase.co` gibi bir adrestir.
   - **anon public** anahtarı. Yeni projelerde adı **publishable key** olabilir.
6. GitHub'daki deponuzda `www/config.js` dosyasını açın ve kalem simgesiyle düzenleyin.
   - `BURAYA_PROJECT_URL` yazan yere Project URL'yi yapıştırın.
   - `BURAYA_ANON_KEY` yazan yere anahtarı yapıştırın.
   - **Commit changes** deyin.
7. Yeni APK birkaç dakika içinde otomatik derlenir. Releases sayfasından indirip eskisinin üstüne kurun. Kayıtlarınız silinmez.
8. Uygulamada en üstteki hesap düğmesine dokunun, ardından **Hesap oluştur**. Diğer telefonlarda aynı e-posta ve şifreyle **Giriş yap** deyin.

> Ücretsiz Supabase projesi bir hafta hiç kullanılmazsa uykuya geçer. Veriler silinmez. supabase.com panelinde projeye girip **Restore** demeniz yeterli. Uygulamayı düzenli kullanırsanız uykuya geçmez.

### 4. Piyasa verisini güncel tutmak (isteğe bağlı)

- **Dolar ve euro:** İnternet varken TCMB'den otomatik alınır.
- **Diğer veriler:** Altın, politika faizi, enflasyon, kart, eksi hesap ve kredi faizleri `www/market.json` dosyasından gelir.
- **Yeni APK kurmadan güncellemek için:**
  - `www/config.js` içindeki `MARKET_URL` satırına şu adresi yazın:
    `https://raw.githubusercontent.com/KULLANICI_ADINIZ/maas-pusulasi/main/www/market.json`
  - Bundan sonra GitHub'da `market.json` dosyasını düzenlediğinizde uygulama yeni değerleri internete bağlandığında kendisi alır.
  - Değerleri güncellemesi için Claude'dan da yardım isteyebilirsiniz.

---

## Notlar

- **İmza anahtarı:** `keystore/debug.keystore` bir test imzası. Sürümlerin birbirinin üstüne kurulabilmesini sağlıyor. Play Store'a yüklemek için ayrı bir yayın imzası gerekir.
- **Uyarı:** Uygulama genel bilgilendirme amaçlıdır, yatırım danışmanlığı değildir. Fon kodlarını alım öncesi TEFAS'ta doğrulayın.
