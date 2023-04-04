import Foundation

// NSObject required Foundation

/*
 struct -> Error
 Property cannot be marked @objc because its type cannot be represented in Objective-C
 
 convert class & inherit NSObject
 */
class Product: NSObject {
    let name: String
    let price: Int
    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
}
class ViewModel: NSObject {
    @objc dynamic var product:Product? = Product(name: "Hat", price: 4000)
    override init() {
        super.init()
        setObserve()
    }
    func change(product: Product) {
        self.product = product
    }
    var ob: [NSKeyValueObservation] = []
    private func setObserve() {
        let ob = self.observe(\.product,options: [.old,.new], changeHandler: {
            object, change in
            print(change.oldValue)
            print(change.newValue)
        })
        self.ob.append(ob)
    }
}
/*
 without @objc keyword
 error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
 The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.
 
 without dynamic keyword
 No Observe
 
 // both @objc and dynamic required
 @objc -> Objective-c runtime을 사용할거야
 dynamic -> Objective-c의 dynamic dispatch를 사용할거야
 */
let vm = ViewModel()
vm.change(product: Product(name: "Shoe", price: 5000))
