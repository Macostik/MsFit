//  
//  PrivacyPolicySceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 14.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PrivacyPolicySceneViewController: BaseViewController<PrivacyPolicySceneViewModel> {
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "سياسة الخصوصية"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private lazy var pravicyTextTextView = specify(UITextView(), {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        style.alignment = .right
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: Constants.sH_812 ? 15 : Constants.sH_667 ? 14 : 12 ),
            .foregroundColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1),
            .paragraphStyle: style
        ]
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        $0.attributedText = NSAttributedString(string: """
        Privacy Policy
        Your    privacy    is    important    to    Paofit    Holdings    Pte    Ltd    and    its    subsidiaries    (herein    “Ms    Fit”),    as    is    the privacy    of    all    users    of    Ms    Fit    mobile    applicaBons,    sites    and    services    (collecBvely    the    "Service").    This policy    tells    you    what    informaBon    we    gather    from    you,    how    we    may    use    or    disclose    that informaBon    and    our    efforts    to    protect    it.    Please    read    this    policy    carefully,    and    feel    free    to    contact us    if    you    have    any    quesBons    regarding    its    content. Before    using    the    Service,    we    will    ask    you    to    agree    on    the    collecBng,    processing    and    use    of    the    data as    outlined    in    this    Policy.    You    are    free    to    decide    whether    to    give    your    consent.    However,    please note    that    in    case    of    withholding    consent,    you    may    not    be    able    to    unrestrictedly    use    our    Service since    some    parts    of    the    services    requires    certain    data    processing    and    data    usage.
        Profile Data
        When    you    register    to    use    the    Service,    we    ask    for    and    store    user    informaBon,    including    required and    opBonal    data,    username,    email,    locaBon,    and    all    personally    idenBfiable    informaBon    not specific    to    ApplicaBon    Usage    Data    ("Profile    Data").    Profile    Data    may    be    recorded    by    the    Service    in order    to    support    registraBon    and    maintenance    of    user    accounts.    We    may    provide    differenBated content    you    receive    in    future    visits    to    the    Service    based    on    your    preferences    and    acBviBes    as determined    based    upon    such    Profile    Data.    APer    you    register    to    use    the    Service,    you    may    choose    to allow    the    Service    to    receive    and    transmit    User    Content    on    your    behalf.    We    will    collect    informaBon about    interacBons    you    have    with    the    Service,    along    with    any    interacBons    you    may    have    with    other users    of    the    Service.    We    collect    and    retain    this    informaBon    so    that    we    can    provide    you    the    Service and    offer    personalized    features.
        Application Usage Data
        InformaBon    on    user    usage    of    the    Service,    such    as    pages    visited,    frequency    of    use,    Bme    on    site, etc…    ("ApplicaBon    Usage    Data")    may    be    recorded    by    the    Service.    ApplicaBon    Usage    Data    can    also include    the    IP    address    where    you    has    logged    in,    as    well    as    device-specific    machine    IDs    or    other unique    idenBfiers    given    to    the    electronic    devices    or    computers    where    the    Service    is    running    that has    accessed    the    Ms    Fit    system.    Ms    Fit    may    use    these    data    to    deliver    the    Service    as    well    as    to monitor    and    assist    in    improvements    to    the    Service.
        Personal Data
        We    may    also    use    your    Profile    Data    and    ApplicaBon    Usage    Data    (collecBvely    “Personal    Data”)    to provide    and    improve    the    Service;    to    provide    you    with    more    effecBve    customer    service    and/or technical    support;    to    provide    you    with    important    informaBon    about    the    Service;    for    security    or fraud    prevenBon    purposes;    and    for    any    other    purposes    outlined    in    this    Privacy    Policy.    Ms    Fit employees    may    look    at    your    Personal    Data    for    development    and    test    purposes.    Personal    Data    will not    be    shared    with    third    parBes    except    in    the    case    of    third    party    service    providers    and    legal processes,    as    noted    below.
        Aggregate Data
        The    Service    may    store    non-personally    idenBfiable    data,    calculated    data    such    as    counts,    averages, and    other    staBsBcs    based    on    user    submiYed    Account    or    Log    Data    (“Aggregate    Data”).    Aggregate data    does    not    containing    any    idenBfiable    informaBon    on    one    specific    user.    Ms    Fit    may    use    these data    to    provide    and    improve    the    Service;    to    provide    you    with    more    effecBve    customer    service    and/ or    technical    support;    to    provide    you    with    important    informaBon    about    the    Service;    for    security    or fraud    prevenBon    purposes;    and    for    any    other    purposes    outlined    in    this    Privacy    Policy.
        User Submitted Content and Data
        We    will    store    data    in    standard    electronic    files    and    in    database    entries    in    the    databases    uBlized    in the    Service.    Ms    Fit-approved    applicaBons    will    access    the    Service    to    pull    data    specific    to    each    user as    well    as    Aggregate    Data    that    is    not    personally    idenBfiable.    The    informaBon    may    be    displayed    to you    in    the    applicaBon,    or    displayed    to    other    users    in    the    case    of    Aggregate    Data.    Since    Aggregate Data    is    not    personally    idenBfiable,    it    may    be    made    public    and    would    not    require    users    to    be    logged in    to    gain    access.
        Ms    Fit    may    use    Personal    Data,    User    Content    and/or    Aggregate    Data    to    provide    and    improve    our products    and    services.    This    may    include    analysis    of    user    or    aggregate    data    in    order    to    idenBfy trends,    idenBfy    markets,    and    to    understand    more    about    the    use    of    our    products    and    services.    We may    also    communicate    with    you    about    device    or    equipment    specific    criBcal    informaBon    such    as warranty    or    product    service    informaBon.    In    addiBon,    Ms    Fit    may    provide    adverBsing    content making    use    of    this    data.    Finally,    Ms    Fit    has    the    right    to    access    any    data    at    any    Bme    for    purposes    of delivering,    improving    or    maintaining    Ms    Fit    products    and    systems    if    necessary.    Third    parBes,    third party    applicaBons    and    websites    will    only    have    access    to    Personal    Data    or    User    Content    if    it    is required    for    Ms    Fit    to    deliver    the    Service.
        Cookies
        Ms    Fit    may    use    cookies    on    the    Service    to    ensure    the    integrity    of    the    registraBon    process    and    to personalize    the    Service.    A    cookie    is    a    small    text    file    that    is    placed    on    your    hard    disk.    Cookies    cannot be    used    to    run    programs    or    deliver    viruses    to    your    computer.    Cookies    are    uniquely    assigned    to    you, and    serve    two    main    purposes:    1)    maintaining    a    consistent    user    experience    while    you    are    using    the Service    and    2)    saving    your    personalized    se]ngs    so    that    when    you    return    to    the    Service,    the informaBon    you    previously    provided    can    be    retrieved,    and    you    can    easily    use    the    features    that    you customized.
        Some    cookies    are    deleted    when    you    close    your    browser.    Others    remain    on    your    computer    and allow    us    to    idenBfy    your    computer,    although    not    you    specifically,    when    you    return    to    the    Service. This    allows    us    to    improve    the    Service    and    tailor    it    to    our    customer’s    needs.
        In    some    cases,    we    may    choose    to    link    the    informaBon    collected    by    our    cookies    in    order    to    beYer personalize    your    experience    with    the    Service    and,    perhaps,    even    save    you    the    trouble    of    having    to re-enter    informaBon    that    you    already    provided    to    us.
        Third    party    ads    may    be    displayed    on    the    Service    and    the    ads    may    also    contain    cookies    set    by    the adverBser,    ad    network,    or    their    agent.    Ms    Fit    does    not    control    these    cookies.    Users    of    Ms    Fit Services    should    consult    the    privacy    policies    of    the    adverBser,    ad    network    or    their    agent    to    learn how    they    use    cookies.
        You    have    the    ability    to    accept    or    reject    cookies,    or    to    set    your    browser    to    alert    you    when    a    web    site implants    a    cookie    on    your    computer.    If    you    choose    to    reject    cookies,    you    may    not    be    able    to    use interacBve    features    of    the    Site.
        Legal Compliance
        We    may    disclose    Personal    Data,    User    Content,    Aggregate    Data,    or    any    other    informaBon    we    collect to    fulfill    legal    or    regulatory    requirements    or    if    we    believe,    in    good    faith,    that    such    disclosure    is legally    required    or    necessary    to    protect    others'    rights    or    to    prevent    harm.    We    may    make    such disclosures    without    noBfying    you.
        We    also    reserve    the    right    to    transfer    your    Personal    Data,    User    Content,    Aggregate    Data,    or    any other    informaBon    we    collect    to    another    company    in    the    event    of    acquisiBon    (of    stock    or    assets)    of Ms    Fit,    a    merger,    or    other    similar    corporate    event,    including    but    not    limited    to    reorganizaBon, restructuring,    or    dissoluBon.    In    the    event    of    such    transfer,    Ms    Fit    will    exercise    commercially reasonable    efforts    to    ensure    that    this    Privacy    Policy    or    another    policy    that    protects    your    Personal Data    and    User    Content    to    the    same    or    similar    extent    will    conBnue    to    apply.
        Third Party Service Providers
        We    also    reserve    the    right    to    transfer    your    Personal    Data,    User    Content,    Aggregate    Data,    or    any other    informaBon    we    collect    to    another    company    in    the    event    of    acquisiBon    (of    stock    or    assets)    of Ms    Fit,    a    merger,    or    other    similar    corporate    event,    including    but    not    limited    to    reorganizaBon, restructuring,    or    dissoluBon.    In    the    event    of    such    transfer,    Ms    Fit    will    exercise    commercially reasonable    efforts    to    ensure    that    this    Privacy    Policy    or    another    policy    that    protects    your    Personal Data    and    User    Content    to    the    same    or    similar    extent    will    conBnue    to    apply.
        Ms    Fit    may    provide    you    with    opportuniBes    to    connect    with    third    party    applicaBons    or    services (“Third    Party    Services”)    via    the    Service.    If    you    choose    to    use    any    such    Third    Party    Services,    we    may facilitate    sharing    of    your    informaBon,    including    your    ApplicaBon    Usage    Data    and    Profile    Data.    Third parBes    may    contact    you    directly    as    necessary.    Your    use    of    such    applicaBons    and    services    is    not governed    by    Ms    Fit's    Terms    of    Service    or    Privacy    Policy.    Ms    Fit    does    not    control    the    applicaBons    or services    of    those    third    parBes    or    how    they    use    your    informaBon.    Be    sure    to    review    the    terms    and the    privacy    policies    of    Third    Party    Services    prior    to    using    the    Third    Party    Services.
        Apple Health App
        Ms    Fit    is    integrated    with    the    Apple    Health    app    using    HealthKit.    Users    can    control    their    individual data    integraBon    under    the    "USING    THE    HEALTH    APP"    secBon    in    the    app    se]ngs. Ms    Fit    will    not    use    or    disclose    to    third    parBes    user    data    gathered    from    the    HealthKit    API    or    from health-related    human    subject    research    for    adverBsing    or    other    use-based    data    mining    purposes other    than    improving    health,    or    for    the    purpose    of    health    research.
        Security
        Ms    Fit    may    provide    you    with    opportuniBes    to    connect    with    third    party    applicaBons    or    services (“Third    Party    Services”)    via    the    Service.    If    you    choose    to    use    any    such    Third    Party    Services,    we    may facilitate    sharing    of    your    informaBon,    including    your    ApplicaBon    Usage    Data    and    Profile    Data.    Third parBes    may    contact    you    directly    as    necessary.    Your    use    of    such    applicaBons    and    services    is    not governed    by    Ms    Fit's    Terms    of    Service    or    Privacy    Policy.    Ms    Fit    does    not    control    the    applicaBons    or services    of    those    third    parBes    or    how    they    use    your    informaBon.    Be    sure    to    review    the    terms    and the    privacy    policies    of    Third    Party    Services    prior    to    using    the    Third    Party    Services. Your    account    informaBon    and    access    to    our    service    is    accessible    only    through    the    use    of    an individual    user    ID    and    password.    To    protect    the    confidenBality    of    personal    informaBon,    you    must keep    your    password    confidenBal    and    not    disclose    it    to    others.    Please    advise    us    immediately    if    you believe    your    password    has    been    misused.    Please    note    that    Ms    Fit    will    never    ask    you    to    disclose your    password    in    an    unsolicited    phone    call    or    email.
        Minimum Age
        Users    of    the    Service    must    be    at    least    13    years    of    age.    We    do    not    knowingly    accept    registraBons   from    users    that    are    under    13.    We    will    delete    accounts    of    any    users    that    we    find    to    be    under    age.    If you    are    aware    that    a    child    under    the    age    of    13    has    become    a    registered    user,    please    inform    us    so   that    we    can    confirm    and    take    the    appropriate    steps    to    re-move    the    account    and    any    related informaBon.
        Communication
        Ms    Fit    may    send    you    account    acBvity-related    announcements    from    Bme    to    Bme.
        Changes to Privacy Policy
        It    may    be    necessary    from    Bme    to    Bme    for    us    to    modify    this    policy    to    reflect    changes    in    the    way    we collect    and    use    informaBon    or    changes    in    privacy-related    laws,    regulaBons,    and    industry    standards. Accordingly,    we    reserve    the    right    to    change    this    policy    at    any    Bme    by    posBng    the    re-vised    policy    on this    Service.    This    policy    was    updated    on    December    10,    2014.    Data    will    be    handled    in    accordance with    the    policy    in    effect    at    the    Bme    the    data    is    used.
        """, attributes: attributes)
    })
    
    override func setupUI() {
       handleUI()
       addConstraints()
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = .systemBackground
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navTextLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 5) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navTextLabel).leading(4).size(44) })
        view.add(pravicyTextTextView, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing().bottom()
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
