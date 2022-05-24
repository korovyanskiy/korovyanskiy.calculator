protocol UserData {
    var userName: String { get }    //Имя пользователя
    var userCardId: String { get }   //Номер карты
    var userCardPin: Int { get }       //Пин-код
    var userPhone: String { get }       //Номер телефона
    var userCash: Float { get set }   //Наличные пользователя
    var userBankDeposit: Float { get set }   //Банковский депозит
    var userPhoneBalance: Float { get set }    //Баланс телефона
    var userCardBalance: Float { get set }    //Баланс карты
}

class UserName: UserData {
    var userName: String
    
    var userCardId: String
    
    var userCardPin: Int
    
    var userPhone: String
    
    var userCash: Float = 1000
    
    var userBankDeposit: Float = 10000
    
    var userPhoneBalance: Float = 0
    
    var userCardBalance: Float = 8000
    
    enum MoneyFromWhat {
        case card
        case cash
    }
    
    init(userName: String, userCardId: String, userCardPin: Int, userPhone: String) {
        self.userName = userName
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.userPhone = userPhone
        
    }
    
    func showBalanceBankDeposit() -> String {
        "Your balance is \(userBankDeposit)"
    }
    
    func withdrawal(withdrawalSum: Float, withdrawalBalance: String) -> String {
        if withdrawalBalance == "Card Balance" {
            userCardBalance -= withdrawalSum
            return "Your made withdrawal \(withdrawalSum). Your card balance is \(userCardBalance)"
            
        }
        else {
            userBankDeposit -= withdrawalSum
            return "You've made withdrawal \(withdrawalSum). Your card balance is \(userBankDeposit)"
        }
    }
    func replenishment(replenishmentSum: Float) -> String {
        userCardBalance += replenishmentSum
        return "You replenish \(replenishmentSum). Your card balance is \(userCardBalance)"
    }
    
    func moneyForMobile(addMoney: Float, moneyfrom: MoneyFromWhat) -> String {
        switch moneyfrom {
        case .card:
            userCardBalance -= addMoney
            return "You've add \(addMoney) to your mobile. Your card balance is \(userCardBalance)"
        case .cash:
            userCash -= addMoney
            return "You've add \(addMoney) to your mobile. Your cash balance is \(userCash)"
        }
    }
}


var userIgor = UserName(userName: "Igor", userCardId: "909019", userCardPin: 1234, userPhone: "89001234567")

// 1. Запрос баланса
userIgor.userBankDeposit // запрос баланса
userIgor.showBalanceBankDeposit() // запрос баланса

// 2. Снятие наличных

userIgor.withdrawal(withdrawalSum: 900, withdrawalBalance: "Card Balance")

// 3. Пополнение карты

userIgor.replenishment(replenishmentSum: 810)

// 4. Пополнение баланс мобильного телефона с карты

userIgor.moneyForMobile(addMoney: 100, moneyfrom: .card)

