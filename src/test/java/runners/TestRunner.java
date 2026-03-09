package runners;

import com.intuit.karate.junit5.Karate;

class TestRunner {

    @Karate.Test
    Karate runTests() {
        return Karate.run("classpath:features")
//                .tags("~@ignore"); // modify tags for execute an specific scenario
                .tags("@test"); // modify tags for execute an specific scenario
    }

}