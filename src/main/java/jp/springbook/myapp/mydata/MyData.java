package jp.springbook.myapp.mydata;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.NotNull;

@RooJavaBean
@RooToString
@RooJpaActiveRecord(finders = { "findMyDatasByNameLike" })
public class MyData {

    /**
     */
    @NotNull
    private String name;

    /**
     */
    @NotNull
    private String mail;

    /**
     */
    private Integer age;

    /**
     */
    private String memo;
}
