import 'package:flutter/material.dart';

class LocationDropDownButton extends StatefulWidget {

  final Function(String) onSelected;
  final List<String> countryNames;
  final List<String> countryFlagUris;

  const LocationDropDownButton({
    Key key,
    @required this.onSelected,
    @required this.countryNames,
    @required this.countryFlagUris
  }) : super(key: key);

  @override
  _LocationDropDownButtonState createState() => _LocationDropDownButtonState();
}

class _LocationDropDownButtonState extends State<LocationDropDownButton> {

  bool isOpen;
  final String keyName = 'dropdown';
  GlobalKey labelKey;
  double height, width, x, y;
  OverlayEntry overlay;

  String _currentLocation;

  @override
  void initState() {
    isOpen = false;
    labelKey = LabeledGlobalKey(keyName);
    _currentLocation = 'India';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadDropDownSemantics(){
    RenderBox renderObject = labelKey.currentContext.findRenderObject();
    height = renderObject.size.height;
    width = renderObject.size.width;
    Offset offset = renderObject.localToGlobal(Offset.zero);
    x = offset.dx; y = offset.dy;
  }

  Widget _buildDropdownItem(String location, String flagUrl) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          widget.onSelected(location);
          overlay.remove();
          isOpen = !isOpen;
          setState(() {
            _currentLocation = location;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          color: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    flagUrl,
                    width: 45,
                    height: 30,
                    fit: BoxFit.fill,
                  )
                )
              ),
              SizedBox(width: 12,),
              Expanded(
                flex: 2,
                child: Text(
                    location,
                  maxLines: 1,
                  style: Theme.of(context).primaryTextTheme.bodyText2,
                  overflow: TextOverflow.ellipsis,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }


  // dropdown overlay
  OverlayEntry _buildDropDown(List<String> locations, List<String> flags){
    double dropdownWidthExtent = 90;
    return OverlayEntry(
        builder: (context) {
          return Positioned(
            left: x - dropdownWidthExtent,
            top: y + height + 10,
            width: width + dropdownWidthExtent,
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.teal[800],
                  borderRadius: BorderRadius.circular(8)
                ),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: locations.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return _buildDropdownItem(locations[index], flags[index]);
                    }
                ),
              ),
            )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: labelKey,
      // gesture handler
      onTap: () {
        if(isOpen) {
          overlay.remove();
        } else {
          _loadDropDownSemantics();
          overlay = _buildDropDown(widget.countryNames, widget.countryFlagUris);
          Overlay.of(context).insert(overlay);
        }
        isOpen = !isOpen;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(12),
        ),
        width: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                _currentLocation,
                style: Theme.of(context).primaryTextTheme.bodyText2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
            )
          ],
        )
      ),
    );
  }
}

class DummyDropdown extends StatelessWidget {

  final String hint;

  const DummyDropdown(
      {Key key,
       @required this.hint
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        width: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                hint,
                style: TextStyle(
                    fontSize: 14
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
            )
          ],
        )
    );
  }
}

