# Flutter ile Paycell MPos App to App Entegrasyon Dokümanı

Entegrasyon örnek uygulaması her bir adım farklı branchden yapılarak tamamlanmış olup **001** isimli branchten başlayarak sırası ile branchleri değiştirdiğiniz durumda entegrasyonun bütün adımlarını ve yapılan işlemleri görebileceksiniz.

Entegrasyona başlamadan önce **android/app/build.gradle** içerisinde aşağıdaki değişiklikleri yapmanız gerekmektedir.

Uygulamanızın minSdkVersion'unu 21 olarak ayarlamanız gerekmektedir.

    defaultConfig {
		minSdkVersion 21
		...
		///Other configs
	}
App to app entegrasyon bazı durumlarda debug modda çalışırken release modda çalışmama davranışı sergilemektedir. Bu sebeple yine **android/app/build.gradle** içerisinde aşağıdaki değişikliği yapmanız gerekmektedir.

    buildTypes {
	    release {
		    shrinkResources false
		    minifyEnabled false
		    ...
	    }
    }

# Branchler ve İçerikleri

**001** -> Tarafınıza iletilen .aar dosyanının Flutter kodu içerisinde kullanılabilmesi için gerekli adımlar.

**002** -> İlgili methodları kullanabilmek için native kod yazılması.

**003** -> Methodlara request atarken ve response alırken kullanacağımız modellerin oluşturulması.
> **Note:** Modellerde kullanılan parametler ve parametrelerin açıklamaları, ilgili model dosyalarının içerisinde, ilgili parametrenin üzerinde yorum satırlarında belirtilmiştir.
> 

**004** -> Native tarafa yazdığımız fonksiyonları çağırabilmek için Method Channel kullanılarak bir servis oluşturulması.

**005** -> Paycell App to App uygulamasının tetikleyerek ödeme aldığımız örnek ekranın oluşturulması.

**006** -> Debug modda sorunsuz çalışan entegrasyonun release modda çalışmaması durumunda yapılacak işlemler.

> **Note:** App to App entegrasyon debug modda test edilirken MPos üzerindeki işlemler tamamlandıktan sonra tetikleyen uygulamanın tekrar açılması aşamasında bazen ilgili uygulamanın crash olmasına sebebiyet vermektedir. Release buildlerde bu tarz bir sorunlar karşılaşılmadı.
