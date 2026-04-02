global class FlightAgent {

    @InvocableMethod(label='Find Flights' description='Finds available flights')
    global static List<FlightResponse> findFlights(List<FlightRequest> req) {
        List<FlightResponse> flightResponses = new List<FlightResponse>();

        // For example, we hardcode the data and don’t focus on how we retrieve it.
        // However, consider that we receive available flight data from a service
        // and then iterate through the data to generate the final response.

        List<Flight> flights = new List<Flight>();
        Flight f1 = new Flight('IX 2814', 1, false, 1000l, 20.20d, 70);
        Flight f2 = new Flight('6E 488', 2, false, 2000l, 15.15d, 120);
        Flight f3 = new Flight('6E 523', 1, false, 3000l, 13.14d, 75);
        Flight f4 = new Flight('6E 6166', 2, false, 4000l, 14.14d, 130);
        flights.add(f1);  flights.add(f2); flights.add(f3); flights.add(f4);
        AvailableFlight availableFlights = new AvailableFlight();
        availableFlights.flights = flights;

        FlightResponse fr = new FlightResponse();
        fr.aFlight = availableFlights;
        flightResponses.add(fr);

        return flightResponses;
    }

    // Input Format for Lightning Types (Agentforce)
    @JsonAccess(serializable='always' deserializable='always')
    global class FlightRequest {

        @InvocableVariable
        global String originCity;

        @InvocableVariable
        global String destinationCity;

        @InvocableVariable
        global Date dateOfTravel;

        @InvocableVariable
        global FlightRequestFilter filters;
    }

    @JsonAccess(serializable='always' deserializable='always')
    global class FlightRequestFilter {

        @AuraEnabled
        global Long price;

        @AuraEnabled
        global Double discountPercentage;
    }

    // Output Format for Lightning Types (Agentforce)
    @JsonAccess(serializable='always' deserializable='always')
    global class FlightResponse {

        @InvocableVariable
        global AvailableFlight aFlight;
    }

    @JsonAccess(serializable='always' deserializable='always')
    global class AvailableFlight {

        @AuraEnabled
        global List<Flight> flights;
    }

    @JsonAccess(serializable='always' deserializable='always')
    global class Flight {

        @AuraEnabled
        global String flightId;

        @AuraEnabled
        global Integer numLayovers;

        @AuraEnabled
        global Boolean isPetAllowed;

        @AuraEnabled
        global Long price;

        @AuraEnabled
        global Double discountPercentage;

        @AuraEnabled
        global Integer durationInMin;

        global Flight(String flightId, Integer numLayovers, Boolean isPetAllowed,
                    Long price, Double discountPercentage, Integer durationInMin) {
            this.flightId = flightId;
            this.numLayovers = numLayovers;
            this.isPetAllowed = isPetAllowed;
            this.price = price;
            this.discountPercentage = discountPercentage;
            this.durationInMin = durationInMin;
        }
    }
}