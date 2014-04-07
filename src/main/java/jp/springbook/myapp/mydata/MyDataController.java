package jp.springbook.myapp.mydata;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.roo.addon.web.mvc.controller.finder.RooWebFinder;

@RequestMapping("/mydatas")
@Controller
@RooWebScaffold(path = "mydatas", formBackingObject = MyData.class)
@RooWebFinder
public class MyDataController {
}
