我们在React Native中使用flexbox规则来指定某个组件的子元素的布局。Flexbox可以在不同屏幕尺寸上提供一致的布局结构。

一般来说，使用`flexDirection`、`alignItems`和 `justifyContent`三个样式属性就已经能满足大多数布局需求。译注：这里有一份[简易布局图解](http://weibo.com/1712131295/CoRnElNkZ?ref=collection&type=comment)，可以给你一个大概的印象。  

![flexbox0](http://ww4.sinaimg.cn/mw690/660d0cdfjw1etlhxhx0lgj218g0xc76b.jpg)
![flexbox1](http://ww1.sinaimg.cn/mw690/660d0cdfjw1etlhxise4kj218g0xc0vf.jpg)
![flexbox2](http://ww1.sinaimg.cn/mw690/660d0cdfjw1etlhxjtkfwj218g0xcwhp.jpg)
![flexbox3](http://ww3.sinaimg.cn/mw690/660d0cdfjw1etlhxjven9j218g0xcgp4.jpg)
![flexbox4](http://ww4.sinaimg.cn/mw690/660d0cdfjw1etlhxkrusyj218g0xcwhn.jpg)
![flexbox4](http://ww4.sinaimg.cn/mw690/660d0cdfjw1etlhxl3605j218g0xcwip.jpg)

> React Native中的Flexbox的工作原理和web上的CSS基本一致，当然也存在少许差异。首先是默认值不同：`flexDirection`的默认值是`column`而不是`row`，而`flex`也只能指定一个数字值。

#### Flex Direction

在组件的`style`中指定`flexDirection`可以决定布局的**主轴**。子元素是应该沿着**水平轴(`row`)**方向排列，还是沿着**竖直轴(`column`)**方向排列呢？默认值是**竖直轴(`column`)**方向。

```ReactNativeWebPlayer
import React, { Component } from 'react';
import { AppRegistry, View } from 'react-native';

class FlexDirectionBasics extends Component {
  render() {
    return (
      // 尝试把`flexDirection`改为`column`看看
      <View style={{flex: 1, flexDirection: 'row'}}>
        <View style={{width: 50, height: 50, backgroundColor: 'powderblue'}} />
        <View style={{width: 50, height: 50, backgroundColor: 'skyblue'}} />
        <View style={{width: 50, height: 50, backgroundColor: 'steelblue'}} />
      </View>
    );
  }
};

AppRegistry.registerComponent('AwesomeProject', () => FlexDirectionBasics);
```

#### Justify Content

在组件的style中指定`justifyContent`可以决定其子元素沿着**主轴**的**排列方式**。子元素是应该靠近主轴的起始端还是末尾段分布呢？亦或应该均匀分布？对应的这些可选项有：`flex-start`、`center`、`flex-end`、`space-around`以及`space-between`。

```ReactNativeWebPlayer
import React, { Component } from 'react';
import { AppRegistry, View } from 'react-native';

class JustifyContentBasics extends Component {
  render() {
    return (
      // 尝试把`justifyContent`改为`center`看看
      // 尝试把`flexDirection`改为`row`看看
      <View style={{
        flex: 1,
        flexDirection: 'column',
        justifyContent: 'space-between',
      }}>
        <View style={{width: 50, height: 50, backgroundColor: 'powderblue'}} />
        <View style={{width: 50, height: 50, backgroundColor: 'skyblue'}} />
        <View style={{width: 50, height: 50, backgroundColor: 'steelblue'}} />
      </View>
    );
  }
};

AppRegistry.registerComponent('AwesomeProject', () => JustifyContentBasics);
```

#### Align Items(alignself)

在组件的style中指定`alignItems`可以决定其子元素沿着**次轴**（与主轴垂直的轴，比如若主轴方向为`row`，则次轴方向为`column`）的**排列方式**。子元素是应该靠近次轴的起始端还是末尾段分布呢？亦或应该均匀分布？对应的这些可选项有：`flex-start`、`center`、`flex-end`以及`stretch`。

> 注意：要使`stretch`选项生效的话，子元素在次轴方向上不能有固定的尺寸。以下面的代码为例：只有将子元素样式中的`width: 50`去掉之后，`alignItems: 'stretch'`才能生效。

```ReactNativeWebPlayer
import React, { Component } from 'react';
import { AppRegistry, View } from 'react-native';

class AlignItemsBasics extends Component {
  render() {
    return (
      // 尝试把`alignItems`改为`flex-start`看看
      // 尝试把`justifyContent`改为`flex-end`看看
      // 尝试把`flexDirection`改为`row`看看
      <View style={{
        flex: 1,
        flexDirection: 'column',
        justifyContent: 'center',
        alignItems: 'center',
      }}>
        <View style={{width: 50, height: 50, backgroundColor: 'powderblue'}} />
        <View style={{width: 50, height: 50, backgroundColor: 'skyblue'}} />
        <View style={{width: 50, height: 50, backgroundColor: 'steelblue'}} />
      </View>
    );
  }
};

AppRegistry.registerComponent('AwesomeProject', () => AlignItemsBasics);
```

#### 深入学习

以上我们已经介绍了一些基础知识，但要运用好布局，我们还需要很多其他的样式。对于布局有影响的完整样式列表记录在[这篇文档中](https://github.com/reactnativecn/react-native.cn/blob/stable/docs/docs/0.41/layout-props.md)。






<div class="props">
    <div class="prop"><h4 class="propTitle"><a class="anchor" name="alignitems"></a>alignItems <span class="propType">enum('flex-start', 'flex-end', 'center', 'stretch')</span>
        <a class="hash-link" href="#alignitems">#</a></h4>
        <div><p><code>alignItems</code>决定了子元素在次轴方向的排列方式（此样式设置在父元素上）。例如若子元素本来是沿着竖直方向排列的（即主轴竖直，次轴水平），则<code>alignItems</code>决定了它们在水平方向的排列方式。此样式和CSS中的<code>align-items</code>表现一致，默认值为stretch。访问<a href="https://developer.mozilla.org/en-US/docs/Web/CSS/align-items">https://developer.mozilla.org/en-US/docs/Web/CSS/align-items</a>来进一步了解。</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="alignself"></a>alignSelf <span class="propType">enum('auto', 'flex-start', 'flex-end', 'center', 'stretch')</span>
        <a class="hash-link" href="#alignself">#</a></h4>
        <div><p><code>alignSelf</code>决定了元素在父元素的次轴方向的排列方式（此样式设置在子元素上），其值会覆盖父元素的<code>alignItems</code>的值。其表现和CSS上的<code>align-self</code>一致（默认值为auto）。访问<a href="https://developer.mozilla.org/en-US/docs/Web/CSS/align-self">https://developer.mozilla.org/en-US/docs/Web/CSS/align-self</a>来进一步了解。</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="bottom"></a>bottom <span
            class="propType">number</span> <a class="hash-link" href="#bottom">#</a></h4>
        <div><p><code>bottom</code>值是指将本组件定位到距离底部多少个逻辑像素（底部的定义取决于<code>position</code>属性）。</p>
            <p>它的表现和CSS上的<code>bottom</code>类似，但注意在React Native上只能使用逻辑像素值（数字单位），而不能使用百分比、em或是任何其他单位。</p>
            <p>访问<a href="https://developer.mozilla.org/en-US/docs/Web/CSS/bottom">https://developer.mozilla.org/en-US/docs/Web/CSS/bottom</a>来进一步了解<code>bottom</code>是如何影响布局的。</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="flex"></a>flex <span class="propType">number</span>
        <a class="hash-link" href="#flex">#</a></h4>
        <div><p>在React Native中<code>flex</code>的表现和CSS有些区别。
            <code>flex</code>在RN中只能为整数值，其具体表现请参考<code>yoga引擎库</code>的文档，其网址是<a href="https://github.com/facebook/yoga">https://github.com/facebook/yoga</a></p>
            <p>当<code>flex</code>取正整数值时， is a positive number, it makes the component flexible
                and it will be sized proportional to its flex value. So a
                component with <code>flex</code> set to 2 will take twice the space as a
                component with <code>flex</code> set to 1.</p>
            <p> When <code>flex</code> is 0, the component is sized according to <code>width</code>
                and <code>height</code> and it is inflexible.</p>
            <p> When <code>flex</code> is -1, the component is normally sized according
                <code>width</code> and <code>height</code>. However, if there's not enough space,
                the component will shrink to its <code>minWidth</code> and <code>minHeight</code>.</p>
            <p>flexGrow, flexShrink, and flexBasis work the same as in CSS.</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="flexbasis"></a>flexBasis <span class="propType">number</span>
        <a class="hash-link" href="#flexbasis">#</a></h4></div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="flexdirection"></a>flexDirection <span
            class="propType">enum('row', 'row-reverse', 'column', 'column-reverse')</span> <a class="hash-link"
                                                                                              href="#flexdirection">#</a>
    </h4>
        <div><p><code>flexDirection</code> controls which directions children of a container go.
            <code>row</code> goes left to right, <code>column</code> goes top to bottom, and you may
            be able to guess what the other two do. It works like <code>flex-direction</code>
            in CSS, except the default is <code>column</code>.访问<a href="https://developer.mozilla.org/en-US/docs/Web/CSS/flex-direction">https://developer.mozilla.org/en-US/docs/Web/CSS/flex-direction</a>来进一步了解。</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="flexgrow"></a>flexGrow <span
            class="propType">number</span> <a class="hash-link" href="#flexgrow">#</a></h4></div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="flexshrink"></a>flexShrink <span class="propType">number</span>
        <a class="hash-link" href="#flexshrink">#</a></h4></div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="flexwrap"></a>flexWrap <span class="propType">enum('wrap', 'nowrap')</span>
        <a class="hash-link" href="#flexwrap">#</a></h4>
        <div><p><code>flexWrap</code> controls whether children can wrap around after they
            hit the end of a flex container.
            It works like <code>flex-wrap</code> in CSS (default: nowrap).访问<a href="https://developer.mozilla.org/en-US/docs/Web/CSS/flex-wrap">https://developer.mozilla.org/en-US/docs/Web/CSS/flex-wrap</a>来进一步了解。</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="height"></a>height <span
            class="propType">number</span> <a class="hash-link" href="#height">#</a></h4>
        <div><p><code>height</code>用于设置组件的高度。</p>
            <p> It works similarly to <code>height</code> in CSS, but in React Native you
                must use logical pixel units, rather than percents, ems, or any of that.访问<a href="https://developer.mozilla.org/en-US/docs/Web/CSS/height">https://developer.mozilla.org/en-US/docs/Web/CSS/height</a>来进一步了解。</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="justifycontent"></a>justifyContent <span
            class="propType">enum('flex-start', 'flex-end', 'center', 'space-between', 'space-around')</span> <a
            class="hash-link" href="#justifycontent">#</a></h4>
        <div><p><code>justifyContent</code> aligns children in the main direction.
            For example, if children are flowing vertically, <code>justifyContent</code>
            controls how they align vertically.
            It works like <code>justify-content</code> in CSS (default: flex-start).访问<a href="https://developer.mozilla.org/en-US/docs/Web/CSS/justify-content">https://developer.mozilla.org/en-US/docs/Web/CSS/justify-content</a>来进一步了解。</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="maxheight"></a>maxHeight <span class="propType">number</span>
        <a class="hash-link" href="#maxheight">#</a></h4>
        <div><p><code>maxHeight</code> is the maximum height for this component, in logical pixels.</p>
            <p> It works similarly to <code>max-height</code> in CSS, but in React Native you
                must use logical pixel units, rather than percents, ems, or any of that.</p>
            <p>访问<a href="https://developer.mozilla.org/en-US/docs/Web/CSS/max-height">https://developer.mozilla.org/en-US/docs/Web/CSS/max-height</a>来进一步了解。</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="maxwidth"></a>maxWidth <span
            class="propType">number</span> <a class="hash-link" href="#maxwidth">#</a></h4>
        <div><p><code>maxWidth</code> is the maximum width for this component, in logical pixels.</p>
            <p> It works similarly to <code>max-width</code> in CSS, but in React Native you
                must use logical pixel units, rather than percents, ems, or any of that.</p>
            <p>访问<a href="https://developer.mozilla.org/en-US/docs/Web/CSS/max-width">https://developer.mozilla.org/en-US/docs/Web/CSS/max-width</a>来进一步了解。</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="minheight"></a>minHeight <span class="propType">number</span>
        <a class="hash-link" href="#minheight">#</a></h4>
        <div><p><code>minHeight</code> is the minimum height for this component, in logical pixels.</p>
            <p> It works similarly to <code>min-height</code> in CSS, but in React Native you
                must use logical pixel units, rather than percents, ems, or any of that.</p>
            <p>访问<a href="https://developer.mozilla.org/en-US/docs/Web/CSS/min-height">https://developer.mozilla.org/en-US/docs/Web/CSS/min-height</a>来进一步了解。</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="minwidth"></a>minWidth <span
            class="propType">number</span> <a class="hash-link" href="#minwidth">#</a></h4>
        <div><p><code>minWidth</code> is the minimum width for this component, in logical pixels.</p>
            <p> It works similarly to <code>min-width</code> in CSS, but in React Native you
                must use logical pixel units, rather than percents, ems, or any of that.</p>
            <p>访问<a href="https://developer.mozilla.org/en-US/docs/Web/CSS/min-width">https://developer.mozilla.org/en-US/docs/Web/CSS/min-width</a>来进一步了解。</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="overflow"></a>overflow <span class="propType">enum('visible', 'hidden', 'scroll')</span>
        <a class="hash-link" href="#overflow">#</a></h4>
        <div><p><code>overflow</code> controls how a children are measured and displayed.
            <code>overflow: hidden</code> causes views to be clipped while <code>overflow: scroll</code>
            causes views to be measured independently of their parents main axis.<code>It works like</code>overflow` in
            CSS (default: visible).访问<a href="https://developer.mozilla.org/en/docs/Web/CSS/overflow">https://developer.mozilla.org/en/docs/Web/CSS/overflow</a>来进一步了解。</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="position"></a>position <span class="propType">enum('absolute', 'relative')</span>
        <a class="hash-link" href="#position">#</a></h4>
        <div><p><code>position</code> in React Native is similar to regular CSS, but
            everything is set to <code>relative</code> by default, so <code>absolute</code>
            positioning is always just relative to the parent.</p>
            <p> If you want to position a child using specific numbers of logical
                pixels relative to its parent, set the child to have <code>absolute</code>
                position.</p>
            <p> If you want to position a child relative to something
                that is not its parent, just don't use styles for that. Use the
                component tree.</p>
            <p>访问<a href="https://facebook.github.io/yoga/docs/absolute-position/">https://facebook.github.io/yoga/docs/absolute-position/</a>来进一步了解<code>position</code>在React Native和CSS中的差异。</p></div>
    </div>

    <div class="prop"><h4 class="propTitle"><a class="anchor" name="zindex"></a>zIndex <span
            class="propType">number</span> <a class="hash-link" href="#zindex">#</a></h4>
        <div><p><code>zIndex</code> controls which components display on top of others.
            Normally, you don't use <code>zIndex</code>. Components render according to
            their order in the document tree, so later components draw over
            earlier ones. <code>zIndex</code> may be useful if you have animations or custom
            modal interfaces where you don't want this behavior.</p>
            <p> It works like the CSS <code>z-index</code> property - components with a larger
                <code>zIndex</code> will render on top. Think of the z-direction like it's
                pointing from the phone into your eyeball.访问<a href="https://developer.mozilla.org/en-US/docs/Web/CSS/z-index">https://developer.mozilla.org/en-US/docs/Web/CSS/z-index</a>
来进一步了解。</p></div>
    </div>
</div>
