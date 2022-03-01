package lecture.springboot_simple;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Date;


// trigger ci

@RestController
public class SimpleController {

    @GetMapping("/datetime")
    public ResponseEntity<String> getDateTime() {
        String res = "Server Time: " + new Date().toString();
        return ResponseEntity.ok(res);
    }
}
