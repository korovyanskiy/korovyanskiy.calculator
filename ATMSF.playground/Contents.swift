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

enum UserActions {
    case userPressedBalanceBtn
    case userPressedTopUpAccount(topUp: Float)
    case userPressedWithdrawCashAccount(withdrawalCash: Float)
    case userPressedPayPhone(phone: String)
 
}

enum DescriptionTypesAvailableOperations: String {
    case balance = "ЗАПРОСИТЬ БАЛАНС"
    case phone = "ПОПОЛНЕНИЕ БАЛАНСА ТЕЛЕФОНА"
    case withdrawal = "ОПЕРАЦИЯ СНЯТИЯ СРЕДСТВ С ДЕПОЗИТА"
    case topUp = "ПОПОЛНЕНИЕ ДЕПОЗИТА"
}

enum PaymentMethod {
    case cash (cash: Float)
    case bankDeposit (cash: Float)
}

enum TextErrors: String {
    case CARD_NUMBER_OR_PIN_INCORRECT = "ДАННЫЕ КАРТЫ ВВЕДЕНЫ НЕВЕРНО"
    case ENTERED_INCORRECT_PHONE = "ВВЕДЕН НЕВЕРНЫЙ НОМЕР ТЕЛЕФОНА"
    case YOU_DONT_HAVE_ENOUGH_CASH = "У ВАС НЕДОСТАТОЧНО НАЛИЧНЫХ"
    case YOU_DONT_HAVE_ENOUGH_FINDS_DEPOSIT = "У ВАС НЕДОСТАТОЧНО СРЕДСТВ НА СЧЕТЕ"
}

protocol BankApi {
    func showUserBalance()
    func showUserToppedUpMobilePhoneCash(cash: Float)
    func showUserToppedUpMobilePhoneDeposit(deposit: Float)
    func showWithdrawalDeposit(cash: Float)
    func showTopUpAccount(cash: Float)
    func showError(error: TextErrors)
 
    func checkUserPhone(phone: String) -> Bool
    func checkMaxUserCash(cash: Float) -> Bool
    func checkMaxAccountDeposit(withdraw: Float) -> Bool
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool
 
    mutating func topUpPhoneBalanceCash(pay: Float)
    mutating func topUpPhoneBalanceDeposit(pay: Float)
    mutating func getCashFromDeposit(cash: Float)
    mutating func putCashDeposit(topUp: Float)
}
struct BankServer: BankApi {
    private var user: UserData
    
    init (user: UserData) {
        self.user = user
    }
    
    public func showUserBalance() {
        let report = """
    Здравствуйте, \(user.userName)
    \(DescriptionTypesAvailableOperations.balance.rawValue)
    Ваш баланс депозита: \(user.userBankDeposit) рублей
    """
        print (report)
    }
    
    public func showUserToppedUpMoilePhoneCash(cash: Float){
        let report = """
    Здравствуйте, \(user.userName)
    \(DescriptionTypesAvailableOperations.phone.rawValue)
    вы пополни баланс наличным на сумму: \(cash)
    у вас осталось \(user.userCash)
    баланс телефона: \(user.userPhoneBalance)
    """
    print(report)
    }
    
    public func showUserToppedUpMoilePhoneDeposit(deposit: Float){
        let report = """
    Здравствуйте, \(user.userName)
    \(DescriptionTypesAvailableOperations.phone.rawValue)
    вы пополни баланс с депозита на сумму: \(deposit)
    у вас осталось \(user.userBankDeposit)
    баланс телефона: \(user.userPhoneBalance)
    """
    print(report)
    }
    
    public func showWithdrawalDeposit(cash: Float){
        let report = """
    Здравствуйте, \(user.userName)
    \(DescriptionTypesAvailableOperations.withdrawal.rawValue)
    вы сняли с депозита: \(cash)
    у вас осталось \(user.userBankDeposit)
    """
    print(report)
    }
    
    public func showTopUpAccount(cash: Float){
        let report = """
    Здравствуйте, \(user.userName)
    \(DescriptionTypesAvailableOperations.topUp.rawValue)
    вы пополнили депозит: \(cash)
    Сумма депозита: \(user.userBankDeposit)
    у вас осталось \(user.userCash)
    """
    print(report)
    }
    
    func showError(error: TextErrors) {
        let error = """
    Здравствуйте, \(user.userName)
    Ошибка: \(error.rawValue)
    """
    }
    
    public mutating func putCashDeposit(topUp: Float) {
        user.userBankDeposit += topUp
        user.userCash += topUp
    }
    
    public mutating func getCashDeposit(topUp: Float) {
        user.userBankDeposit -= cash
        user.userCash -= cash
    }
    
    public mutating func topUpPhoneBalanceCash(pay: Float) {
        user.userPhoneBalance += pay
        user.userCash -= pay
    }
    
    public mutating func topUpPhoneBalanceDeposit(pay: Float) {
        user.userPhoneBalance += pay
        user.userBankDeposit -= pay
    }
    
    public func checkMaxAccountdeposit(withdraw: Float) -> Bool {
        if withdraw <= user.userBankDeposit {
            return true
        }
        return false
    }
    
    public func checkMaxUserCash(cash: Float) -> Bool {
        if cash <= user.userCash {
            return true
        }
        return false
    }
    
    public func checkMaxUserPhone(phone: String) -> Bool {
        if phone == user.userPhone {
            return true
        }
        return false
    }
    
    public func checkCurrentUser(pin: userCardId: String, userCardPin: Int) -> Bool {
        let isCorrectId = checkId(id: userCardId, user: user)
        let isCorrectedPin = checkPin(pin: userCardPin, user: user)
        
        if isCorrectId && isCorrectedPin {
            return true
        }
        return false
    }
 
    private func checkPin(pin: Int, user: userData) -> Bool {
        if pin == user.userCardPin {
            return true
        }
        return false
    }
    
    private func checkId(id: String, user: userData) -> Bool {
        if id == user.userCardId {
            return true
        }
        return false
    }
}
class ATM {
    private let userCardId: String
    private let userCardPin: Int
    private var someBank: BankApi
    private let action: UserActions
    private let paymentMethod: PaymentMethod?
 
    init(userCardId: String, userCardPin: Int, someBank: BankApi, action: UserActions, paymentMethod: PaymentMethod? = nil) {
 
 
    sendUserDataToBank(userCardId: userCardId, userCardPin: userCardPin, actions: action, payment: paymentMethod)
  }
 
 
  public final func sendUserDataToBank(userCardId: String, userCardPin: Int, actions: UserActions, payment: PaymentMethod?) {
      let ifUserExist = someBank.checkCurrentUser(userCardId: userCardId, userCardPin: userCardPin)
      if isUserExist {
          switch actions {
          case .userPressedBalanceBtn:
              someBank.showUserBalance()
          case let .userPressedPayPhone(phone):
              if someBank.checkUserPhone(phone: phone) {
                  if let payment = payment {
                      switch payment {
                      case let .cash(cash: payment):
                          if someBank.checkMaxUserCash(cash: payment){
                              someBank.topUpPhoneBalanceCash(pay: payment)
                              someBank.showUserToppedUpMobilePhoneCash(cash: payment)
                          } else {
                              someBank.showError (error .YOU_DONT_HAVE_ENOUGH_CASH)
                          }
                      case let .deposit(deposit: payment)
                          if someBank.checkMaxAccountDeposit(withdraw: payment) {
                              someBank.topUpPhoneBalanceDeposit(pay: payment)
                              someBank.showUserToppedUpMobilePhoneDeposit(deposit: payment)
                          } else {
                              someBank.showError(error .YOU_DONT_HAVE_ENOUGH_FINDS_DEPOSIT)
                          }
                      }
                  } else {
                      someBank.showError(error .ENTERRED_INCORRECT_PHONE)
                  }
              case let .userPressedTopUpAccount(topUp: payment):
                  if someBank.checkMaxUserCash(cash: payment) {
                      someBank.putCashDeposit(topUp: payment)
                      someBank.showTopUpAccount(cash: payment)
                  } else {
                      some.showError(error .YOU_DONT_HAVE_ENOUGH_CASH)
                  }
              case let .userPressedWithdrawalCashAccount(withdrawCash):
                  if someBank.checkMaxUserAccountDeposit(withdraw: withdrawCash) {
                      someBank.getCashFromDeposit(cash: withdrawCash)
                      someBank.showWithdrawalDeposit(cash: withdrawCash)
                  } else {
                      someBank.showError(error .YOU_DONT_HAVE_ENOUGH_FINDS_DEPOSIT)
                  }
          }
          case .userPressedTopUpAccount(topUp: let topUp):
              <#code#>
          case .userPressedWithdrawCashAccount(withdrawalCash: let withdrawalCash):
              <#code#>
          }; else do {
              someBank.showError(error .CARD_NUMBER_OR_PIN_INCORRECT)
          }
  }
}

                                 struct User: UserData {
                  var userCardBalance: Float
                  
                  var userName: String
                  var userCardId: String
                  var userCardPin: Int
                  var userCash: Float
                  var userBankDeposit: Float
                  var userPhone: String
                  var userPhoneBalance: Float
              }
                                 
let userIgor = userData(
    userName: "Igor",
    userCardId: "1230987",
    userCardPin: "0000",
    userPhone: "89210000000",
    userCash: 120000.00,
    userBankDeposit: 23000000.00,
    userPhoneBalance: 0.00
    userCardBalance: 5689.00
)

let bankClient = BankServer(user: Igor)

let atm1 = ATM(
    userCardId: "1230987",
    userCardPin: 0000,
    someBank: bankClient,
    action: .userPressedPayPhone (phone: "89210000000"),
    paymentMethod: .cash (cash: 1000)
)
                                 }
