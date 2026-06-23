// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navMap => 'Mapa';

  @override
  String get navExplore => 'Explorar';

  @override
  String get navMissions => 'Misiones';

  @override
  String get navRank => 'Ranking';

  @override
  String get navProfile => 'Perfil';

  @override
  String get authOrContinueWith => 'o continúa con';

  @override
  String get authGoogle => 'Google';

  @override
  String get authEmailLabel => 'Correo electrónico';

  @override
  String get authEmailHint => 'tu@gmail.com';

  @override
  String get authPasswordLabel => 'Contraseña';

  @override
  String get authPasswordHint => '********';

  @override
  String get authNameLabel => 'Nombre';

  @override
  String get authNameHint => 'Alex Vidal';

  @override
  String get authLogIn => 'Iniciar sesión';

  @override
  String get authPasswordMustContain => 'La contraseña debe contener:';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDismiss => 'Cerrar';

  @override
  String get commonBack => 'Atrás';

  @override
  String get commonCopy => 'Copiar';

  @override
  String get commonDone => 'Listo';

  @override
  String get commonSeeAll => 'Ver todo';

  @override
  String get commonViewAll => 'Ver todo';

  @override
  String get commonFollow => 'Seguir';

  @override
  String get commonFollowing => 'Siguiendo';

  @override
  String get commonBlock => 'Bloquear';

  @override
  String get commonShowMore => 'Ver más';

  @override
  String get commonShowLess => 'Ver menos';

  @override
  String get commonProgress => 'Progreso';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonContinue => 'Continuar';

  @override
  String commonLevel(int level) {
    return 'Nivel $level';
  }

  @override
  String commonPointsShort(int points) {
    return '+$points pts';
  }

  @override
  String get loginWelcomeTitle => 'Bienvenido de nuevo';

  @override
  String get loginWelcomeSubtitle => 'Tus locales te esperan.';

  @override
  String get loginRememberMe => 'Recordarme';

  @override
  String get loginForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get loginNewHere => '¿Eres nuevo?';

  @override
  String get loginCreateAccount => 'Crear cuenta';

  @override
  String get signupTitle => 'Únete a locals';

  @override
  String get signupSubtitle => 'Empieza a coleccionar lugares auténticos.';

  @override
  String get signupButton => 'Crear cuenta';

  @override
  String get signupAlreadyLocal => '¿Ya eres local?';

  @override
  String get otpResetPasswordTitle => 'Restablece tu contraseña';

  @override
  String get otpResetPasswordSubtitle =>
      'Usa el mismo correo con el que creaste la cuenta';

  @override
  String get otpHint6Digit =>
      'Hemos enviado un código de 6 dígitos a tu correo';

  @override
  String get otpHint4Digit =>
      'Hemos enviado un código de 4 dígitos a tu correo';

  @override
  String get otpVerifyHeader => 'Verificar';

  @override
  String get otpVerifyButton => 'Verificar OTP';

  @override
  String get otpDidntReceiveCode => '¿No recibiste el código?';

  @override
  String get otpResend => 'Reenviar';

  @override
  String get otpEmailVerifiedTitle => 'Correo verificado';

  @override
  String get otpEmailVerifiedMessage =>
      'Tu correo se ha verificado correctamente.';

  @override
  String get requestOtpButton => 'Solicitar OTP';

  @override
  String get setPasswordTitle => 'Crea una nueva contraseña';

  @override
  String get setPasswordSubtitle => 'Crea algo único pero memorable';

  @override
  String get setPasswordNewLabel => 'Nueva contraseña';

  @override
  String get setPasswordNewHint => 'Algo seguro';

  @override
  String get setPasswordConfirmLabel => 'Confirmar contraseña';

  @override
  String get setPasswordConfirmHint => 'Confirma tu contraseña';

  @override
  String get setPasswordButton => 'Restablecer contraseña';

  @override
  String get setPasswordBackTo => 'Volver a';

  @override
  String get setPasswordSuccessTitle => 'Contraseña cambiada';

  @override
  String get setPasswordSuccessMessage =>
      'Tu contraseña se ha cambiado correctamente.';

  @override
  String get passwordReqMinLength => 'Al menos 8 caracteres';

  @override
  String get passwordReqUppercase => 'Contiene letra mayúscula';

  @override
  String get passwordReqLowercase => 'Contiene letra minúscula';

  @override
  String get passwordReqNumber => 'Contiene número';

  @override
  String get dialogLogoutTitle => '¿Cerrar sesión?';

  @override
  String get dialogLogoutMessage =>
      'Tendrás que iniciar sesión de nuevo para acceder a tu perfil, misiones y lugares guardados.';

  @override
  String get dialogLogoutConfirm => 'Cerrar sesión';

  @override
  String get dialogDeleteAccountTitle => '¿Eliminar cuenta?';

  @override
  String get dialogDeleteAccountMessage =>
      'Esto elimina permanentemente tu perfil, progreso y datos guardados. Esta acción no se puede deshacer.';

  @override
  String get dialogDeleteAccountConfirm => 'Eliminar cuenta';

  @override
  String legalLastUpdated(String date) {
    return 'Última actualización: $date';
  }

  @override
  String get onboardSkip => 'Omitir';

  @override
  String get onboardNotNow => 'Ahora no';

  @override
  String get onboardPage1Title => 'Descubre lugares locales auténticos';

  @override
  String get onboardPage1Subtitle =>
      'Lugares seleccionados con el sello de locals — los que de verdad aman los vecinos.';

  @override
  String get onboardPage2Title => 'Colecciona lugares, gana puntos';

  @override
  String get onboardPage2Subtitle =>
      'Haz check-in cuando visites. Cada lugar auténtico forma parte de tu mapa.';

  @override
  String get onboardPage3Title => 'Sube de nivel, completa ciudades';

  @override
  String get onboardPage3Subtitle =>
      'Escala en el ranking, desbloquea logros y persigue el 100% de completado.';

  @override
  String get onboardPage4Title => 'Encuentra locales cerca de ti';

  @override
  String get onboardPage4Subtitle =>
      'Usamos tu ubicación para mostrar lugares auténticos cercanos y confirmar tus check-ins. Tu ubicación nunca se comparte con otros usuarios.';

  @override
  String get onboardContinue => 'Continuar';

  @override
  String get onboardGetStarted => 'Empezar';

  @override
  String get onboardAllowLocation => 'Permitir ubicación';

  @override
  String get exploreNewLocals => 'NUEVOS LOCALES';

  @override
  String get localShares => 'acciones locales';

  @override
  String get exploreFeaturedLocations => 'LUGARES DESTACADOS';

  @override
  String get exploreFeaturedRoutes => 'RUTAS DESTACADAS';

  @override
  String get exploreFindLocalsToFollow => 'ENCUENTRA LOCALES PARA SEGUIR';

  @override
  String get exploreRecentActivity => 'ACTIVIDAD RECIENTE';

  @override
  String get exploreWeeklyRanking => 'RANKING SEMANAL';

  @override
  String get exploreAllEvents => 'Todos los eventos';

  @override
  String exploreNewCategory(String category) {
    return 'NUEVO · $category';
  }

  @override
  String get exploreYourStory => 'Tu historia';

  @override
  String get exploreViewYourStory => 'Ver tu historia';

  @override
  String get exploreAddPhoto => 'Añadir foto';

  @override
  String get findLocalsTitle => 'Encontrar locales';

  @override
  String get featuredLocationsTitle => 'Lugares destacados';

  @override
  String get eventsRoutesTitle => 'Eventos y rutas';

  @override
  String eventsByOrganizer(String organizer) {
    return 'Por $organizer';
  }

  @override
  String eventSponsoredBy(String sponsor) {
    return 'Patrocinado · $sponsor';
  }

  @override
  String get joinEventRouteStops => 'PARADAS DE LA RUTA';

  @override
  String get joinEventButton => 'Unirse al evento';

  @override
  String get joinEventJoined => 'Unido';

  @override
  String get eventCheckInNextStop => 'Check-in en la siguiente parada';

  @override
  String get eventRouteComplete => 'Ruta completada';

  @override
  String get restaurantLocalsSeal => 'sello de locals';

  @override
  String get restaurantLocalSpot => 'Lugar local';

  @override
  String get restaurantBeenHere => 'He estado aquí';

  @override
  String get restaurantBeenHereDone => 'He estado aquí ✓';

  @override
  String get restaurantDirections => 'Cómo llegar';

  @override
  String get restaurantPhotos => 'Fotos';

  @override
  String get restaurantVisitors => 'Visitantes';

  @override
  String get shareLocationTitle => 'Compartir el lugar';

  @override
  String get storyDeleteTooltip => 'Eliminar esta historia';

  @override
  String get storyViewersTitle => 'Espectadores';

  @override
  String get storyViewersEmpty => 'Nadie ha visto esta historia todavía.';

  @override
  String get storyDeletePhotoTitle => '¿Eliminar esta foto?';

  @override
  String get storyDeletePhotoMessage =>
      'Solo se eliminará esta diapositiva. Tus otras historias se mantienen.';

  @override
  String get checkInConfirmed => 'CHECK-IN CONFIRMADO';

  @override
  String checkInLocationYours(String locationName) {
    return '$locationName es tuyo.';
  }

  @override
  String get checkInAddedToMap => 'Otro local añadido a tu mapa.';

  @override
  String get checkInShareMoment => 'Compartir momento';

  @override
  String get checkInContinueExploring => 'Seguir explorando';

  @override
  String get shareCardTitle => 'Tarjeta para compartir';

  @override
  String get shareCardTapToCapture => 'Toca para capturar';

  @override
  String get shareCardRetake => 'Repetir';

  @override
  String get shareCardConfirm => 'Confirmar';

  @override
  String get shareCardAddToStory => 'Añadir a la historia';

  @override
  String get shareCardSaving => 'Guardando...';

  @override
  String get shareCardSaved => 'Guardado';

  @override
  String get shareCardSaveImage => 'Guardar imagen';

  @override
  String get shareProfileTitle => 'Comparte tu perfil';

  @override
  String get statVisits => 'VISITAS';

  @override
  String get statCities => 'CIUDADES';

  @override
  String get statFollowers => 'SEGUIDORES';

  @override
  String get statPoints => 'PUNTOS';

  @override
  String get statStops => 'PARADAS';

  @override
  String get statReward => 'RECOMPENSA';

  @override
  String get statProgress => 'PROGRESO';

  @override
  String get statLevel => 'NIVEL';

  @override
  String get statCity => 'CIUDAD';

  @override
  String get mapSearchHint => 'Buscar locales y lugares';

  @override
  String get mapSearchRecent => 'RECIENTES';

  @override
  String get mapSearchTrending => 'TENDENCIAS';

  @override
  String get filtersTitle => 'Filtros';

  @override
  String get filtersReset => 'Restablecer';

  @override
  String get filtersType => 'TIPO';

  @override
  String get filtersStatus => 'ESTADO';

  @override
  String get filtersCategories => 'CATEGORÍAS';

  @override
  String get filtersBusinesses => 'Negocios';

  @override
  String get filtersHerbs => 'Hierbas';

  @override
  String get filtersBoth => 'Ambos';

  @override
  String get filtersVisited => 'Visitados';

  @override
  String get filtersUnvisited => 'No visitados';

  @override
  String get filtersApply => 'Aplicar filtros';

  @override
  String get mapExploring => 'EXPLORANDO';

  @override
  String get mapCompletion => 'COMPLETADO';

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get achievementsTitle => 'Logros';

  @override
  String get missionsTitle => 'Misiones';

  @override
  String get missionsSubtitle =>
      'Desafíos seleccionados para descubrir Barcelona.';

  @override
  String get missionFilterNearby => 'Cerca';

  @override
  String get missionFilterActive => 'Activas';

  @override
  String get missionFilterCompleted => 'Completadas';

  @override
  String get missionFilterEvents => 'Eventos';

  @override
  String get missionStopsSection => 'PARADAS';

  @override
  String get missionContinue => 'Continuar misión';

  @override
  String get achievementsUnlocked => 'DESBLOQUEADOS';

  @override
  String get achievementsKeepVisiting =>
      'Sigue visitando para desbloquear más.';

  @override
  String get rankLeaderboardTitle => 'Clasificación';

  @override
  String get rankScopeCity => 'Ciudad';

  @override
  String get rankScopeCountry => 'País';

  @override
  String get rankScopeGlobal => 'Global';

  @override
  String get rankScopeFollowers => 'Seguidores';

  @override
  String get rankPeriodWeekly => 'Semanal';

  @override
  String get rankPeriodMonthly => 'Mensual';

  @override
  String get rankPeriodAllTime => 'Histórico';

  @override
  String viewProfileTitle(String name) {
    return 'Perfil de $name';
  }

  @override
  String get viewProfileTabPhotos => 'Fotos';

  @override
  String get viewProfileTabMap => 'Mapa';

  @override
  String get viewProfileTabAchievements => 'Logros';

  @override
  String viewProfileLevelLocation(int level, String location) {
    return 'Nivel $level · $location';
  }

  @override
  String get blockUserTitle => 'Bloquear usuario';

  @override
  String blockUserMessage(String name) {
    return '¿Bloquear a $name? No podrá ver tu perfil.';
  }

  @override
  String get blockUserConfirm => 'Bloquear';

  @override
  String profilePointsToNextLevel(int points, int nextLevel) {
    return '$points pts para nivel $nextLevel';
  }

  @override
  String get profileMyMap => 'Mi mapa';

  @override
  String get profileFollowers => 'Seguidores';

  @override
  String get profileSavedPlace => 'Lugar guardado';

  @override
  String get profileBlocked => 'Bloqueados';

  @override
  String get profileRecentAchievements => 'Logros recientes';

  @override
  String get profileLatestVisits => 'Últimas visitas';

  @override
  String get editProfileTitle => 'Editar perfil';

  @override
  String get editProfileName => 'Nombre';

  @override
  String get editProfileLocation => 'Ubicación';

  @override
  String get editProfileSaveChanges => 'Guardar cambios';

  @override
  String get editProfileChangePassword => 'Cambiar contraseña';

  @override
  String get editProfileCurrentPassword => 'Contraseña actual';

  @override
  String get editProfileNewPassword => 'Nueva contraseña';

  @override
  String get editProfileConfirmPassword => 'Confirmar contraseña';

  @override
  String get myMapTitle => 'Mi mapa';

  @override
  String get myMapFilterAll => 'Todos';

  @override
  String myMapFilterVisited(int count) {
    return 'Visitados · $count';
  }

  @override
  String myMapFilterUnvisited(int count) {
    return 'No visitados · $count';
  }

  @override
  String get myMapLegendVisited => 'Visitado';

  @override
  String get myMapLegendUnvisited => 'No visitado';

  @override
  String get listTitle => 'Lista';

  @override
  String listFollowersCount(int count) {
    return 'Seguidores · $count';
  }

  @override
  String listFollowingCount(int count) {
    return 'Siguiendo · $count';
  }

  @override
  String listLevelFollowsYou(int level) {
    return 'Nivel $level · Te sigue';
  }

  @override
  String get blockedListTitle => 'Lista de bloqueados';

  @override
  String get blockedUnblock => 'Desbloquear';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsSectionPreferences => 'PREFERENCIAS';

  @override
  String get settingsSectionAccount => 'CUENTA';

  @override
  String get settingsSectionAbout => 'ACERCA DE';

  @override
  String get settingsSectionDangerZone => 'ZONA DE PELIGRO';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsNotification => 'Notificaciones';

  @override
  String get settingsPrivacy => 'Privacidad';

  @override
  String get settingsEditProfile => 'Editar perfil';

  @override
  String get settingsHelpSupport => 'Ayuda y soporte';

  @override
  String get settingsPrivacyPolicy => 'Privacidad y política';

  @override
  String get settingsRateLocal => 'Valorar Local';

  @override
  String get settingsLogOut => 'Cerrar sesión';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePickerTitle => 'Elegir idioma';

  @override
  String get privacyTitle => 'Privacidad';

  @override
  String get privacySectionProfileVisibility => 'VISIBILIDAD DEL PERFIL';

  @override
  String get privacySectionPhotoVisibility => 'VISIBILIDAD DE FOTOS';

  @override
  String get privacySectionLocationPermission => 'PERMISO DE UBICACIÓN';

  @override
  String get privacySectionLeaderboard => 'MOSTRAR EN CLASIFICACIÓN';

  @override
  String get privacyPublic => 'Público';

  @override
  String get privacyPrivate => 'Privado';

  @override
  String get privacyFollowersOnly => 'Solo seguidores';

  @override
  String get privacyAllTime => 'Siempre';

  @override
  String get privacyWhileUsingApp => 'Al usar la app';

  @override
  String get privacyOn => 'Activado';

  @override
  String get privacyOff => 'Desactivado';

  @override
  String get privacyDataTitle => 'Privacidad y datos';

  @override
  String get privacyDeleteAccount => 'Eliminar mi cuenta';

  @override
  String get privacyPolicyLink => 'Política de privacidad';

  @override
  String get termsOfUseLink => 'Términos de uso';

  @override
  String get termsOfUseTitle => 'Términos de uso';

  @override
  String get privacyPolicyTitle => 'Política de privacidad';

  @override
  String get privacyDataEncryptedTitle => 'Tus datos están cifrados';

  @override
  String get privacyDataEncryptedSubtitle =>
      'La información de salud se almacena localmente y se sincroniza de forma segura.';

  @override
  String get notificationMissionAlerts => 'Alertas de misiones';

  @override
  String get notificationMissionAlertsDesc =>
      'Cuando haya una nueva misión disponible.';

  @override
  String get notificationEvents => 'Eventos';

  @override
  String get notificationEventsDesc => 'Festivales y rutas patrocinadas.';

  @override
  String get notificationAnnouncements => 'Anuncios';

  @override
  String get notificationAnnouncementsDesc =>
      'Festivales y rutas patrocinadas.';

  @override
  String get helpSupportTitle => 'Ayuda y soporte';

  @override
  String get helpSubjectLabel => 'Asunto';

  @override
  String get helpMessageLabel => 'Mensaje';

  @override
  String get helpMessageHint => 'Describe tu problema o pregunta...';

  @override
  String get helpSending => 'Enviando...';

  @override
  String get helpSend => 'Enviar';

  @override
  String helpVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get helpEmailTo => 'Para';

  @override
  String get subscriptionTitle => 'Gestionar suscripción';

  @override
  String get subscriptionCurrentPlan => 'Plan actual';

  @override
  String get subscriptionPremiumUnlocked =>
      'Todas las funciones premium desbloqueadas';

  @override
  String get subscriptionBillingHistory => 'HISTORIAL DE FACTURACIÓN';

  @override
  String get subscriptionUpdatePayment => 'Actualizar';

  @override
  String get subscriptionAutoRenew => 'Renovación automática';

  @override
  String get subscriptionAutoRenewDesc =>
      'Se renovará automáticamente cada mes';

  @override
  String get subscriptionUpgradeYearly => 'Actualizar a anual';

  @override
  String get subscriptionYearlySavings => 'Ahorra 50% · \$4.92/mes';

  @override
  String get subscriptionSwitch => 'Cambiar';

  @override
  String get subscriptionCancel => 'Cancelar suscripción';

  @override
  String get filterCategoryRestaurant => 'Restaurante';

  @override
  String get filterCategoryBar => 'Bar';

  @override
  String get filterCategoryCafe => 'Café';

  @override
  String get filterCategoryBakery => 'Panadería';

  @override
  String get filterCategoryShop => 'Tienda';

  @override
  String get filterCategoryMarket => 'Mercado';

  @override
  String get filterCategoryMonument => 'Monumento';

  @override
  String get filterCategoryCultural => 'Espacio cultural';

  @override
  String get filterCategoryViewpoint => 'Mirador';

  @override
  String get filterCategorySquare => 'Plaza';

  @override
  String get filterCategoryOther => 'Otro';

  @override
  String get snackbarLinkCopied => 'Enlace copiado';

  @override
  String get snackbarCaptureFailed => 'No se pudo capturar la foto';

  @override
  String get snackbarThanksFeedback => '¡Gracias por tus comentarios!';

  @override
  String get snackbarProfileUpdated => 'Perfil actualizado';

  @override
  String get snackbarPasswordsNoMatch => 'Las contraseñas no coinciden';

  @override
  String get snackbarPasswordChanged => 'Contraseña cambiada';

  @override
  String get snackbarPasswordChangeFailed => 'No se pudo cambiar la contraseña';

  @override
  String get snackbarStoryAdded => 'Historia añadida';

  @override
  String photoLikesCount(int count) {
    return '$count me gusta';
  }

  @override
  String get savedPlacesTitle => 'Lugares guardados';

  @override
  String get storyJustNow => 'Ahora mismo';

  @override
  String get snackbarCapturePhotoFirst => 'Captura una foto primero';

  @override
  String get helpWriteMessage => 'Escribe un mensaje';

  @override
  String get helpOpeningEmail => 'Abriendo la app de correo';

  @override
  String get helpCouldNotOpenEmail => 'No se pudo abrir la app de correo';

  @override
  String get cameraNoAvailable =>
      'No hay cámara disponible en este dispositivo.';

  @override
  String get cameraCouldNotOpen =>
      'No se pudo abrir la cámara. Inténtalo de nuevo.';

  @override
  String get shareCardTakePhoto => 'Tomar foto';

  @override
  String get shareCardChooseGallery => 'Elegir de la galería';
}
