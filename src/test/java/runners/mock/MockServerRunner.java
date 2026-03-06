package runners.mock;

import com.intuit.karate.core.MockServer;
// To run the mock server
public class MockServerRunner {
    public static void main(String[] args) {

        MockServer server = MockServer
                .feature("classpath:features/mock/mockServer.feature")
                .http(8080)
                .build();

        System.out.println("Mock server running on port: " + server.getPort());
    }
}