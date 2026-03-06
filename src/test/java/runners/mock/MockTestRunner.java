package runners.mock;

import com.intuit.karate.junit5.Karate;

class MockTestRunner {

    @Karate.Test
    Karate runTests() {
        return Karate.run("classpath:features/mock")
//                .tags("~@ignore"); // modify tags for execute an specific scenario
                .tags("@mock"); // modify tags for execute an specific scenario
    }

}