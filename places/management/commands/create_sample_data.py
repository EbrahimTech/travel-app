"""
Management command to create sample data for testing
"""
from django.core.management.base import BaseCommand
from places.models import City, Category, Place, PlaceImage


class Command(BaseCommand):
    help = 'Creates sample data for testing the application'

    def handle(self, *args, **options):
        self.stdout.write(self.style.SUCCESS('Creating sample data...'))

        # Create Cities
        istanbul, created = City.objects.get_or_create(
            slug='istanbul',
            defaults={
                'name': 'Istanbul',
                'name_ar': 'إسطنبول',
                'country': 'Turkey',
            }
        )
        if created:
            self.stdout.write(self.style.SUCCESS(f'Created city: {istanbul.name}'))

        antalya, created = City.objects.get_or_create(
            slug='antalya',
            defaults={
                'name': 'Antalya',
                'name_ar': 'أنطاليا',
                'country': 'Turkey',
            }
        )
        if created:
            self.stdout.write(self.style.SUCCESS(f'Created city: {antalya.name}'))

        cappadocia, created = City.objects.get_or_create(
            slug='cappadocia',
            defaults={
                'name': 'Cappadocia',
                'name_ar': 'كابادوكيا',
                'country': 'Turkey',
            }
        )
        if created:
            self.stdout.write(self.style.SUCCESS(f'Created city: {cappadocia.name}'))

        # Create Categories
        restaurant, created = Category.objects.get_or_create(
            slug='restaurant',
            defaults={
                'name': 'Restaurant',
                'name_ar': 'مطعم',
                'icon': 'restaurant',
            }
        )
        if created:
            self.stdout.write(self.style.SUCCESS(f'Created category: {restaurant.name}'))

        attraction, created = Category.objects.get_or_create(
            slug='attraction',
            defaults={
                'name': 'Attraction',
                'name_ar': 'معلم سياحي',
                'icon': 'attraction',
            }
        )
        if created:
            self.stdout.write(self.style.SUCCESS(f'Created category: {attraction.name}'))

        hotel, created = Category.objects.get_or_create(
            slug='hotel',
            defaults={
                'name': 'Hotel',
                'name_ar': 'فندق',
                'icon': 'hotel',
            }
        )
        if created:
            self.stdout.write(self.style.SUCCESS(f'Created category: {hotel.name}'))

        # Create Places
        places_data = [
            {
                'name': 'Hagia Sophia',
                'name_ar': 'آيا صوفيا',
                'city': istanbul,
                'category': attraction,
                'description': 'A historic architectural marvel and former cathedral, later mosque, now museum.',
                'description_ar': 'تحفة معمارية تاريخية كانت كاتدرائية ثم مسجد، والآن متحف.',
                'address': 'Sultan Ahmet, Ayasofya Meydanı No:1, 34122 Fatih/İstanbul',
                'address_ar': 'سلطان أحمد، ميدان آيا صوفيا رقم 1، فاتح/إسطنبول',
                'latitude': 41.0086,
                'longitude': 28.9802,
                'avg_rating': 4.7,
                'total_reviews': 1250,
                'average_price_level': 2,
            },
            {
                'name': 'Blue Mosque',
                'name_ar': 'المسجد الأزرق',
                'city': istanbul,
                'category': attraction,
                'description': 'An iconic mosque with beautiful blue tiles and impressive architecture.',
                'description_ar': 'مسجد أيقوني ببلاط أزرق جميل وعمارة رائعة.',
                'address': 'Sultan Ahmet Mahallesi, Atmeydanı Cd. No:7, 34122 Fatih/İstanbul',
                'address_ar': 'سلطان أحمد، شارع أتميداني رقم 7، فاتح/إسطنبول',
                'latitude': 41.0054,
                'longitude': 28.9769,
                'avg_rating': 4.6,
                'total_reviews': 980,
                'average_price_level': 1,
            },
            {
                'name': 'Nusr-Et Steakhouse',
                'name_ar': 'نصرت ستيك هاوس',
                'city': istanbul,
                'category': restaurant,
                'description': 'Famous steakhouse known for its premium cuts and excellent service.',
                'description_ar': 'مطعم ستيك شهير معروف بقطع اللحم المميزة والخدمة الممتازة.',
                'address': 'Etiler, Nispetiye Cd. No:87, 34337 Beşiktaş/İstanbul',
                'address_ar': 'إتيلر، شارع نيسبيتييه رقم 87، بيشكتاش/إسطنبول',
                'latitude': 41.0819,
                'longitude': 29.0083,
                'avg_rating': 4.5,
                'total_reviews': 450,
                'average_price_level': 4,
            },
            {
                'name': 'Topkapi Palace',
                'name_ar': 'قصر توبكابي',
                'city': istanbul,
                'category': attraction,
                'description': 'Historic palace that was the primary residence of Ottoman sultans.',
                'description_ar': 'قصر تاريخي كان المقر الرئيسي لسلاطين العثمانيين.',
                'address': 'Cankurtaran, 34122 Fatih/İstanbul',
                'address_ar': 'جانكورتاران، فاتح/إسطنبول',
                'latitude': 41.0117,
                'longitude': 28.9850,
                'avg_rating': 4.8,
                'total_reviews': 2100,
                'average_price_level': 3,
            },
            {
                'name': 'Antalya Old Town',
                'name_ar': 'البلدة القديمة أنطاليا',
                'city': antalya,
                'category': attraction,
                'description': 'Charming historic district with narrow streets and traditional architecture.',
                'description_ar': 'حي تاريخي ساحر بشوارع ضيقة وعمارة تقليدية.',
                'address': 'Kaleiçi, 07100 Muratpaşa/Antalya',
                'address_ar': 'قلعة إيجي، مراد باشا/أنطاليا',
                'latitude': 36.8841,
                'longitude': 30.7056,
                'avg_rating': 4.4,
                'total_reviews': 750,
                'average_price_level': 2,
            },
            {
                'name': 'Hot Air Balloon Ride',
                'name_ar': 'رحلة بالون هوائي',
                'city': cappadocia,
                'category': attraction,
                'description': 'Breathtaking hot air balloon experience over the unique landscape of Cappadocia.',
                'description_ar': 'تجربة رائعة بالمنطاد الهوائي فوق المشهد الفريد لكابادوكيا.',
                'address': 'Göreme, 50180 Nevşehir',
                'address_ar': 'غوريم، نوشهير',
                'latitude': 38.6431,
                'longitude': 34.8350,
                'avg_rating': 4.9,
                'total_reviews': 3200,
                'average_price_level': 4,
            },
            {
                'name': 'Sultanahmet Koftecisi',
                'name_ar': 'سلطان أحمد كفتجيسي',
                'city': istanbul,
                'category': restaurant,
                'description': 'Traditional Turkish restaurant serving authentic köfte and Turkish dishes.',
                'description_ar': 'مطعم تركي تقليدي يقدم الكفتة الأصيلة والأطباق التركية.',
                'address': 'Sultan Ahmet, Divan Yolu Cd. No:12, 34110 Fatih/İstanbul',
                'address_ar': 'سلطان أحمد، شارع ديوان يول رقم 12، فاتح/إسطنبول',
                'latitude': 41.0067,
                'longitude': 28.9722,
                'avg_rating': 4.3,
                'total_reviews': 680,
                'average_price_level': 2,
            },
            {
                'name': 'Grand Bazaar',
                'name_ar': 'البازار الكبير',
                'city': istanbul,
                'category': attraction,
                'description': 'One of the largest and oldest covered markets in the world.',
                'description_ar': 'واحد من أكبر وأقدم الأسواق المغطاة في العالم.',
                'address': 'Beyazıt, Kalpakçılar Cd. No:22, 34126 Fatih/İstanbul',
                'address_ar': 'بيازيت، شارع كالباكجيلار رقم 22، فاتح/إسطنبول',
                'latitude': 41.0106,
                'longitude': 28.9683,
                'avg_rating': 4.2,
                'total_reviews': 1500,
                'average_price_level': 2,
            },
        ]

        for place_data in places_data:
            place, created = Place.objects.get_or_create(
                name=place_data['name'],
                city=place_data['city'],
                defaults=place_data
            )
            if created:
                self.stdout.write(self.style.SUCCESS(f'Created place: {place.name}'))
                
                # Add sample images
                if place.name == 'Hagia Sophia':
                    PlaceImage.objects.get_or_create(
                        place=place,
                        defaults={
                            'image_url': 'https://images.unsplash.com/photo-1524231757912-21f4fe3a7200?w=800',
                            'is_cover': True,
                        }
                    )
                elif place.name == 'Blue Mosque':
                    PlaceImage.objects.get_or_create(
                        place=place,
                        defaults={
                            'image_url': 'https://images.unsplash.com/photo-1524231757912-21f4fe3a7200?w=800',
                            'is_cover': True,
                        }
                    )
                elif place.name == 'Hot Air Balloon Ride':
                    PlaceImage.objects.get_or_create(
                        place=place,
                        defaults={
                            'image_url': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
                            'is_cover': True,
                        }
                    )
                else:
                    PlaceImage.objects.get_or_create(
                        place=place,
                        defaults={
                            'image_url': 'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800',
                            'is_cover': True,
                        }
                    )

        self.stdout.write(self.style.SUCCESS('\nSample data created successfully!'))
        self.stdout.write(self.style.SUCCESS(f'Created: {City.objects.count()} cities'))
        self.stdout.write(self.style.SUCCESS(f'Created: {Category.objects.count()} categories'))
        self.stdout.write(self.style.SUCCESS(f'Created: {Place.objects.count()} places'))

