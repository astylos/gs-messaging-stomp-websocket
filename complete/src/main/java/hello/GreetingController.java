package hello;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.util.HtmlUtils;

import java.util.concurrent.atomic.AtomicInteger;

@Controller
public class GreetingController {

	private static AtomicInteger greetingsCounter = new AtomicInteger(0);

	@MessageMapping("/hello")
	@SendTo("/topic/greetings")
	public Greeting greeting(HelloMessage message) throws Exception {
		Thread.sleep(200); // simulated delay
		return new Greeting("Hello, " + HtmlUtils.htmlEscape(message.getName())
				+ "! Greetings since startup: " + greetingsCounter.incrementAndGet());
	}

}
