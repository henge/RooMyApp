// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package jp.springbook.myapp.mydata;

import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import jp.springbook.myapp.mydata.MyData;
import jp.springbook.myapp.mydata.MyDataController;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect MyDataController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String MyDataController.create(@Valid MyData myData, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, myData);
            return "mydatas/create";
        }
        uiModel.asMap().clear();
        myData.persist();
        return "redirect:/mydatas/" + encodeUrlPathSegment(myData.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String MyDataController.createForm(Model uiModel) {
        populateEditForm(uiModel, new MyData());
        return "mydatas/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String MyDataController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("mydata", MyData.findMyData(id));
        uiModel.addAttribute("itemId", id);
        return "mydatas/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String MyDataController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("mydatas", MyData.findMyDataEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) MyData.countMyDatas() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("mydatas", MyData.findAllMyDatas(sortFieldName, sortOrder));
        }
        return "mydatas/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String MyDataController.update(@Valid MyData myData, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, myData);
            return "mydatas/update";
        }
        uiModel.asMap().clear();
        myData.merge();
        return "redirect:/mydatas/" + encodeUrlPathSegment(myData.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String MyDataController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, MyData.findMyData(id));
        return "mydatas/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String MyDataController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        MyData myData = MyData.findMyData(id);
        myData.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/mydatas";
    }
    
    void MyDataController.populateEditForm(Model uiModel, MyData myData) {
        uiModel.addAttribute("myData", myData);
    }
    
    String MyDataController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}