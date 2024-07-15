import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const ParkingApp());
}

class ParkingApp extends StatelessWidget {
  const ParkingApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue,
      ),
      home: const GetStartedPage(),
    );
  }
}

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Parking App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Get Started',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 22),
            ElevatedButton(
              onPressed: () {
                // Navigate to GPS page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GPSPickerPage()),
                );
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}

class GPSPickerPage extends StatelessWidget {
  const GPSPickerPage({Key? key});

  Future<void> _getLocation(BuildContext context) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // Use position to access location information
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Nearest Parking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'GPS Picker Page',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                _getLocation(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Parking App',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement parking reservation logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReserveParkingPage()),
                );
              },
              child: const Text('Reserve Parking'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ReserveParkingPage extends StatelessWidget {
  final List<int> reservedSlots = [2, 4, 6];

  ReserveParkingPage({Key? key}); // Mocking reserved slots

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve Parking'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 10, // Assuming there are 10 slots
          itemBuilder: (BuildContext context, int index) {
            final slotNumber = index + 1;
            final isReserved = reservedSlots.contains(slotNumber);

            return ListTile(
              title: Text('Slot $slotNumber'),
              subtitle: isReserved ? const Text('Reserved') : const Text('Available'),
              trailing: isReserved
                  ? null
                  : ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConfirmReservationPage()),
                  );
                  // Implement reservation logic here
                  // You can navigate to a confirmation page or perform any necessary actions
                },
                child: const Text('Reserve'),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ConfirmReservationPage extends StatefulWidget {
  const ConfirmReservationPage({Key? key});

  @override
  _ConfirmReservationPageState createState() => _ConfirmReservationPageState();
}

class _ConfirmReservationPageState extends State<ConfirmReservationPage> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve Parking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Select a timeslot:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: const Text('Select Date'),
            ),
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: const Text('Select Time'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement reservation logic here
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Reservation'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Selected Timeslot:'),
                          Text(
                              'Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
                          Text('Time: ${_selectedTime.format(context)}'),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RequestServicePage(),
                              ),
                            );
                            // Implement reservation logic here
                            // You can navigate to a confirmation page or perform any necessary actions
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Reserve'),
            ),
          ],
        ),
      ),
    );
  }
}

class RequestServicePage extends StatefulWidget {
  const RequestServicePage({Key? key});

  @override
  _RequestServicePageState createState() => _RequestServicePageState();
}

class _RequestServicePageState extends State<RequestServicePage> {
  String? _selectedService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Service'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedService,
              hint: const Text('Select Service'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedService = newValue;
                });
              },
              items: <String>['Charge Car', 'Car Wash', 'Car Maintenance']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                if (_selectedService != null) {
                  _showServiceRequestConfirmation(context);
                }
              },
              child: const Text('Request Service'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to HomePage when "No Thanks" button is pressed
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentMethodPage()),
                );
              },
              child: const Text('No Thanks'),
            ),
          ],
        ),
      ),
    );
  }

  void _showServiceRequestConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Service Requested"),
          content:
              Text("Your $_selectedService has been requested successfully."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key});

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedPaymentMethod,
              hint: const Text('Select Payment Method'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPaymentMethod = newValue;
                });
              },
              items: <String>['Credit Card', 'Debit Card', 'PayPal']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                if (_selectedPaymentMethod != null) {
                  _showPaymentConfirmation(context);
                }
              },
              child: const Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Payment Confirmed"),
          content: Text("Your payment via $_selectedPaymentMethod is confirmed."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({Key? key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433); // Example initial location
  late Marker _marker;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _marker = Marker(
        markerId: const MarkerId('Home'),
        position: _center,
        infoWindow: const InfoWindow(
          title: 'Parking Location',
          snippet: 'Example Parking',
        ),
        icon: BitmapDescriptor.defaultMarker,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Nearest Parking'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: <Marker>{_marker},
      ),
    );
  }
}
