
Build
------

The project should be build with the default Xcode function Build&Run. It doesn't require any other setup or configuration steps

Application Arhitecture
--------------------------

This application is build with the SOLID arhitecture in mind and using modified version of VIPER. There are 2 VIPER modules:
Search and Details. It's a bit of an overhead for the application of this size but it can be easily tested, extended and changed.


Last.FM API
--------------
Two Last FM HTTP API calls have been implemented:

/2.0/?method=<term>.getinfo
/2.0/?method=<term>.search

getInfo API will be called only for search results that has mbid in the response.

User Inrface
--------------
UI is simple and possible and is there just to provide basic search funtionality. I have sourced simple image loading/caching code
from the github.

Unit tests
-----------

Unit tests are written for Search module only and can be easily extended to Details module.














