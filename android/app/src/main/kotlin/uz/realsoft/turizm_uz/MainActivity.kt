package uz.realsoft.turizm_uz

import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Initialize Yandex MapKit with your API key
        MapKitFactory.setApiKey("c1d88bea-a60d-45af-b426-0c1c9a6be90d")
        MapKitFactory.initialize(this)
    }
}
