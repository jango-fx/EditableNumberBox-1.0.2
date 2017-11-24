public class EditableNumberbox extends Numberbox {

  String text = "";
  boolean active;
  boolean unchanged = true;
  int col;

  EditableNumberbox(ControlP5 theControlP5, java.lang.String theName) {
    super(theControlP5, theName);
    col = color(255);

    addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
        switch(theEvent.getAction()) 
        {
        case ControlP5.ACTION_RELEASED:
          setActive( true );
          break;
        }
      }
    }
    );
  }

  void keyEvent(KeyEvent k) {
    if (k.getAction()==KeyEvent.PRESS && active) {
      if (k.getKey() == ENTER) {
        submit();
        return;
      } else if (k.getKeyCode() == BACKSPACE) {
        unchanged = false;
        deleteLast();  // delete last digit
        //deleteAll(); // clear all text with backspace
      } else if (k.getKey()<255) {
        if (unchanged) {
          text = "";
          unchanged = false;
        }
        // check if the input is a valid (decimal) number
        final String regex = "\\d+([.]\\d{0,2})?";
        if ( java.util.regex.Pattern.matches(regex, text + k.getKey()) ) {
          text += k.getKey();
        }
      }
      this.getValueLabel().setText(this.text);
    }
  }

  Numberbox setValue( float theValue ) {
    setActive(false);
    return super.setValue(theValue);
  }

  void setActive(boolean b) {
    active = b;
    if (active) {
      super.setColorValueLabel(getColor().getActive());
      text = getValueLabel().getText();
    } else
    {      
      super.setColorValueLabel(col);
    }
  }

  void submit() {
    if (!text.isEmpty()) {
      setValue( float( text ) );
      text = "";
    } else {
      getValueLabel().setText(""+getValue());
    }
    setActive( false );
    unchanged = true;
  }

  void deleteAll() { 
    text = "";
  }

  void deleteLast() {
    text = text.isEmpty() ? "":text.substring(0, text.length()-1);
  }

  Numberbox setColorValue(int theColor)
  {
    col = theColor;
    return super.setColorValue(theColor);
  }

  Numberbox setColorValueLabel(int theColor)
  {
    col = theColor;
    return super.setColorValueLabel(theColor);
  }
}