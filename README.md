# iOS Form

| Form Demo                           | New Contact                         |
| ----------------------------------- | ----------------------------------- |
| ![Form demo](/images/form-demo.png) | ![New Contact](/images/contact.png) |

## Implement iOS Form with UITableView

### Create a base controller

Base class `FormViewController` with
- A table view
- A data source to handle data
- Implement table view's data source and delegate

```swift
class FormViewController: UIViewController {

  let tableView = UITableView(frame: .zero, style: .grouped)
  let dataSource = FormDataSource()

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
}

// MARK: - UITableViewDataSource

extension FormViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    dataSource.sections.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataSource.sections[section].fields.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let field = dataSource.sections[indexPath.section].fields[indexPath.row]
    return field.dequeue(for: tableView, at: indexPath)
  }
}

// MARK: - UITableViewDelegate

extension FormViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let field = dataSource.sections[indexPath.section].fields[indexPath.row]
    return field.height
    }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    dataSource.sections[section].header?.dequeue(for: tableView, in: section)
    }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let header = dataSource.sections[section].header else { return .zero }
    return header.height
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let field = dataSource.sections[indexPath.section].fields[indexPath.row]
    field.tableView(tableView, didSelectRowAt: indexPath)
  }
}
```

### Detail about FormDataSource

The class `FormDataSource` contains data that is used for the form.

```swift
final class FormDataSource {

  private(set) var sections: [FormSection] = []
}
```

#### FormSection

`FormSection` contains data for each section on the table view.

```swift
final class FormSection {

  var key: String
  var header: FormHeader?
  var fields: [FormField]

  init(key: String, header: FormHeader? = nil, fields: [FormField]) {
    self.key = key
    self.header = header
    self.fields = fields
  }
}
```

#### FormHeader

A object conform to `FormHeader` protocol, it will contains only the configuration of a header.

With `FormHeader`, easy to create and maintain a header in a `FormSection`.

```swift
import UIKit

protocol FormHeader: AnyObject {

  var key: String { get }
  var height: CGFloat { get }

  func register(for tableView: UITableView)
  func dequeue(for tableView: UITableView, in section: Int) -> UIView?
}
```

How the implementation might look:

```swift
final class TitleFormHeader {

  let key: String
  let viewModel: TitleHeaderFooterViewModel

  init(key: String, viewModel: TitleHeaderFooterViewModel) {
    self.key = key
    self.viewModel = viewModel
  }
}

extension TitleFormHeader: FormHeader {

  var height: CGFloat { 60.0 }

  func register(for tableView: UITableView) {
    tableView.register(TitleHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "TitleHeaderFooterView")
  }

  func dequeue(for tableView: UITableView, in section: Int) -> UIView? {
    let view = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: "TitleHeaderFooterView"
    ) as? TitleHeaderFooterView
    view?.configure(with: viewModel)
    return view
  }
}
```

#### FormField

`FormField` is the most important protocol, for cells in table view, we will have field objects that carry the logic configuration of a view. We will create fields that conform `FormField` for all the cells we want to display in a table view.

```swift
protocol FormField: AnyObject {

  var key: String { get }
  var height: CGFloat { get }
  var delegate: FormFieldDelegate? { get set }

  func register(for tableView: UITableView)
  func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}
```

Here is an example about an implementation of `FormField`

```swift
final class TextInputFormField {

    let key: String
    var viewModel: TextInputViewModel

    weak var delegate: FormFieldDelegate?

    init(key: String, viewModel: TextInputViewModel) {
        self.key = key
        self.viewModel = viewModel
    }
}

// MARK: - FormField

extension TextInputFormField: FormField {

  var height: CGFloat { 44.0 }

  func register(for tableView: UITableView) {
    tableView.register(TextInputCell.self, forCellReuseIdentifier: "TextInputCell")
  }

  func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TextInputCell", for: indexPath) as! TextInputCell
    cell.delegate = self
    cell.configure(viewModel)
    return cell
  }
}
```

## Form Demo

Check out the demo for more detail about different types of cell.

```bash
git clone git@github.com:nimblehq/ios-form.git

pod install
```

## License

This project is Copyright (c) 2014 and onwards. It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About

![Nimble](https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png)

This project is maintained and funded by Nimble.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimblehq
[hire]: https://nimblehq.co/