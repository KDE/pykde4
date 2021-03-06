//
//     Copyright 2008 Jim Bublitz <jbublitz@nwinternet.com>
//     Earlier copyrights 1998 - 2007 Jim Bublitz also apply

//                 Generated by twine

// This file is part of PyKDE4.

// PyKDE4 is free software; you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as
// published by the Free Software Foundation; either version 2.1 of
// the License, or (at your option) any later version.

// PyKDE4 is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

namespace DOM
{

class CSSStyleDeclaration
{
%TypeHeaderCode
#include <css_value.h>
%End


public:
                            CSSStyleDeclaration ();
                            CSSStyleDeclaration (const DOM::CSSStyleDeclaration& other);
//ig                            CSSStyleDeclaration (CSSStyleDeclarationImpl* impl);
    DOM::DOMString          cssText () const;
    void                    setCssText (const DOM::DOMString&);
    unsigned long           length () const;
    DOM::CSSRule            parentRule () const;
    DOM::DOMString          getPropertyValue (const DOM::DOMString& propertyName) const;
    DOM::CSSValue           getPropertyCSSValue (const DOM::DOMString& propertyName) const;
    DOM::DOMString          removeProperty (const DOM::DOMString& propertyName);
    DOM::DOMString          getPropertyPriority (const DOM::DOMString& propertyName) const;
    void                    setProperty (const DOM::DOMString& propertyName, const DOM::DOMString& value, const DOM::DOMString& priority);
//ig    DOM::DOMString          item (unsigned long index) const;
    DOM::DOMString          item (unsigned long index);
//ig    CSSStyleDeclarationImpl*  handle () const;
    bool                    isNull () const;
    ~CSSStyleDeclaration ();
};
// CSSStyleDeclaration


class CSSValue
{
%TypeHeaderCode
#include <css_value.h>
%End


public:
                            CSSValue ();
                            CSSValue (const DOM::CSSValue& other);
//ig                            CSSValue (CSSValueImpl* impl);

    enum UnitTypes
    {
        CSS_INHERIT,
        CSS_PRIMITIVE_VALUE,
        CSS_VALUE_LIST,
        CSS_CUSTOM,
        CSS_INITIAL,
        CSS_SVG_VALUE
    };

    DOM::DOMString          cssText () const;
    void                    setCssText (const DOM::DOMString&);
    unsigned short          cssValueType () const;
    bool                    isCSSValueList () const;
    bool                    isCSSPrimitiveValue () const;
//ig    CSSValueImpl*           handle () const;
    bool                    isNull () const;
    ~CSSValue ();
};
// CSSValue


class CSSValueList : DOM::CSSValue
{
%TypeHeaderCode
#include <css_value.h>
%End


public:
                            CSSValueList ();
                            CSSValueList (const DOM::CSSValueList& other);
                            CSSValueList (const DOM::CSSValue& other);
//ig                            CSSValueList (CSSValueListImpl* impl);
    unsigned long           length () const;
    DOM::CSSValue           item (unsigned long index);
    ~CSSValueList ();
};
// CSSValueList


class CSSPrimitiveValue : DOM::CSSValue
{
%TypeHeaderCode
#include <css_value.h>
%End


public:
                            CSSPrimitiveValue ();
                            CSSPrimitiveValue (const DOM::CSSPrimitiveValue& other);
                            CSSPrimitiveValue (const DOM::CSSValue& other);
//ig                            CSSPrimitiveValue (CSSPrimitiveValueImpl* impl);

    enum UnitTypes
    {
        CSS_UNKNOWN,
        CSS_NUMBER,
        CSS_PERCENTAGE,
        CSS_EMS,
        CSS_EXS,
        CSS_PX,
        CSS_CM,
        CSS_MM,
        CSS_IN,
        CSS_PT,
        CSS_PC,
        CSS_DEG,
        CSS_RAD,
        CSS_GRAD,
        CSS_MS,
        CSS_S,
        CSS_HZ,
        CSS_KHZ,
        CSS_DIMENSION,
        CSS_STRING,
        CSS_URI,
        CSS_IDENT,
        CSS_ATTR,
        CSS_COUNTER,
        CSS_RECT,
        CSS_RGBCOLOR,
        CSS_DPI,
        CSS_DPCM,
        CSS_PAIR,
        CSS_HTML_RELATIVE
    };

    unsigned short          primitiveType () const;
    void                    setFloatValue (unsigned short unitType, float floatValue);
    float                   getFloatValue (unsigned short unitType) const;
    void                    setStringValue (unsigned short stringType, const DOM::DOMString& stringValue);
    DOM::DOMString          getStringValue () const;
    DOM::Counter            getCounterValue () const;
    DOM::Rect               getRectValue () const;
    DOM::RGBColor           getRGBColorValue () const;
    ~CSSPrimitiveValue ();
};
// CSSPrimitiveValue


class RGBColor
{
%TypeHeaderCode
#include <css_value.h>
%End


public:
                            RGBColor ();
                            RGBColor (const QColor& c);
                            RGBColor (QRgb color);
                            RGBColor (const DOM::RGBColor& other);
    DOM::CSSPrimitiveValue  red () const;
    DOM::CSSPrimitiveValue  green () const;
    DOM::CSSPrimitiveValue  blue () const;
    QRgb                    color () const;
    ~RGBColor ();
};
// RGBColor


class Rect
{
%TypeHeaderCode
#include <css_value.h>
%End


public:
                            Rect ();
                            Rect (const DOM::Rect& other);
    DOM::CSSPrimitiveValue  top () const;
    DOM::CSSPrimitiveValue  right () const;
    DOM::CSSPrimitiveValue  bottom () const;
    DOM::CSSPrimitiveValue  left () const;
//ig    RectImpl*               handle () const;
    bool                    isNull () const;

protected:
//ig                            Rect (RectImpl* i);
public:
    ~Rect ();
};
// Rect


class Counter
{
%TypeHeaderCode
#include <css_value.h>
%End


public:
                            Counter ();
                            Counter (const DOM::Counter& other);
    DOM::DOMString          identifier () const;
    DOM::DOMString          listStyle () const;
    DOM::DOMString          separator () const;
//ig    CounterImpl*            handle () const;
    bool                    isNull () const;

protected:
//ig                            Counter (CounterImpl* i);
public:
    ~Counter ();
};
// Counter

};
// DOM


