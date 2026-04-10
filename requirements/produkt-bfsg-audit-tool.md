---
title: "AccessCheck — BFSG/WCAG Audit Tool"
subtitle: "Marktanalyse und Anforderungsdokumentation"
author: "WAMOCON GmbH"
date: "April 2026"
---

**VERTRAULICH**

---

**Datum:** April 2026  
**Version:** 1.2  
**Status:** Zur Freigabe  
**Autor:** WAMOCON GmbH

---

\newpage

# Projektübersicht

Diese Sektion beantwortet alle wesentlichen Fragen auf einen Blick. Die vollständigen Analysen und technischen Spezifikationen folgen in den Abschnitten I und II.

**Wie heißt das Projekt?**
AccessCheck ist ein BFSG/WCAG Audit Tool, entwickelt von der WAMOCON GmbH.

**Was ist das Produkt?**
AccessCheck ist eine Web-Anwendung, die IT-Berater und Agenturen dabei unterstützt, gesetzlich vorgeschriebene Barrierefreiheitsprüfungen (BFSG) für Kunden-Websites schnell und professionell durchzuführen. Das Tool führt den Prüfer durch alle 50 WCAG-Kriterien, speichert Befunde strukturiert und erzeugt automatisch einen professionellen PDF-Auditbericht, der ohne Nacharbeit direkt an den Kunden verschickt werden kann. Die App funktioniert sowohl online als auch offline.

**Wer ist die Zielgruppe?**
Die primäre Zielgruppe sind IT-Berater und Agenturen, die BFSG-Compliance-Audits als bezahlten Service für ihre Kunden durchführen. Als sekundäre Zielgruppe kommen Compliance-Manager in mittelständischen Unternehmen in Betracht.

**Welches Problem löst die App?**
Ein manueller BFSG-Audit dauert heute 8 bis 12 Stunden. Der Berater arbeitet mit einer Excel-Checkliste, erstellt den Report in Word, pflegt Screenshots manuell ein und verbringt allein für die Formatierung mehrere Stunden. AccessCheck reduziert diesen Aufwand auf 4 Stunden, indem eine strukturierte Checkliste, automatische Befundverwaltung und ein direkter PDF-Export bereitgestellt werden.

**Welches ist die wichtigste Funktion?**
Die WCAG-Checkliste mit allen 50 Kriterien (Level A und AA) ist die Kernfunktion. Zu jedem Kriterium, das als fehlerhaft bewertet wird, erscheint automatisch ein vordefinierter Umsetzungshinweis aus der W3C-Spezifikation. Aus diesen Ergebnissen wird ein professioneller PDF-Auditbericht generiert. Das ist das Produkt, das der Berater kauft.

**Welche Hauptfunktionen sind geplant?**
Das MVP umfasst Anmeldung und Authentifizierung, Audit-Verwaltung mit Dashboard und Statusanzeige, die WCAG-Checkliste mit Screenshot-Upload und Befunddokumentation, automatische Umsetzungshinweise je Befund, PDF-Report-Export sowie Offline-Nutzung mit automatischer Synchronisation. Die Landing Page wird als separates Deployment umgesetzt.

**Auf welchen Plattformen läuft die App?**
Die App läuft im Desktop-Browser (primär) und im Tablet-Browser (vollständig nutzbar). Sie kann als Progressive Web App auf Desktop und Mobilgerät installiert werden. Eine native iOS oder Android App ist nicht geplant.

**Soll die App offline funktionieren?**
Ja. Die App unterstützt vollständigen Offline-Betrieb: Bestehende Audits können gelesen, die Checkliste ausgefüllt und neue Audits angelegt werden. Der Report-Export als PDF ist ebenfalls offline möglich. Sobald eine Internetverbindung wiederhergestellt ist, werden alle lokal gespeicherten Änderungen automatisch mit Supabase synchronisiert.

**Gibt es ein Design-Vorbild?**
Es wurde kein konkretes Design-Vorbild festgelegt. Der visuelle Stil ist modern und minimal, orientiert an gängigen SaaS-Dashboard-Patterns mit klarer Typografie und viel Weißraum. Es werden die WAMOCON-Brandfarben verwendet. Ein Dunkelmodus ist für das MVP nicht vorgesehen und kann in einer späteren Version ergänzt werden.

**Welche Datenschutzanforderungen gelten?**
Die App ist DSGVO-konform. Alle Daten werden auf EU-Servern gespeichert (Supabase Frankfurt). Hochgeladene Screenshots werden nicht an KI-Trainingsdaten weitergegeben. Durch Row-Level Security sieht jeder Nutzer ausschließlich seine eigenen Daten.

**Wann soll die App fertig sein?**
Das MVP wird innerhalb einer Woche (5 Arbeitstage) entwickelt, getestet und präsentiert.

**Gibt es ein Budget?**
Es ist kein explizites Entwicklungsbudget definiert. Die App wird durch WAMOCON in Eigenentwicklung umgesetzt. Die laufenden Betriebskosten im MVP sind minimal, da Supabase und Vercel in kostenlosen Tiers genutzt werden. KI-Kosten (OpenAI) entstehen erst ab Phase 2.

**Was ist wichtiger: Qualität oder Geschwindigkeit?**
Für das MVP hat Geschwindigkeit Vorrang. Ein funktionstüchtiger Kernprozess in einer Woche ist das Ziel. KI-Features und Mehrsprachigkeit folgen in Phase 2.

**Hat WAMOCON bereits WCAG-Erfahrung?**
Nein. AccessCheck ist der Startpunkt dieser Erfahrung. Die ersten Audits werden intern an WAMOCON-eigenen Projekten durchgeführt. Das stellt sicher, dass das Tool am realen Arbeitsablauf ausgerichtet ist und nicht an einer theoretischen Checkliste.

**Welchen internen Nutzen hat WAMOCON?**
WAMOCON profitiert doppelt: erstens als bezahlter Audit-Service für externe Kunden, zweitens als internes Qualitätssicherungsinstrument. Alle von WAMOCON entwickelten Webanwendungen werden zukünftig vor dem Launch mit AccessCheck auf WCAG 2.1 AA geprüft.

**Bevorzugter Kommunikationskanal?**
E-Mail via Supabase Auth (Transaktions- und Onboarding-Mails).

---

# Teil I — Marktanalyse

---

## 1. Hintergrund & regulatorischer Kontext

### 1.1 Das Barrierefreiheitsstärkungsgesetz (BFSG)

Das **Barrierefreiheitsstärkungsgesetz (BFSG)** ist die deutsche Umsetzung des **European Accessibility Act (EAA, Richtlinie 2019/882/EU)**. Es gilt seit dem **28. Juni 2025** verbindlich für alle digitalen Produkte und Dienstleistungen die in Deutschland angeboten werden.

**Wer ist betroffen?**

Praktisch jedes Unternehmen das digitale Produkte oder Dienstleistungen anbietet — mit folgenden Ausnahmen:

| Ausnahme | Bedingung |
|---|---|
| Kleinstunternehmen | < 10 Mitarbeitende UND < €2M Jahresumsatz |
| Keine Ausnahme | Alle anderen Unternehmen jeder Größe |

**Was ist betroffen?**

- Websites und Web-Applikationen
- Mobile Apps (iOS, Android)
- E-Commerce-Plattformen (Produktseiten, Checkout, Kundenservice)
- Self-Service-Terminals (Geldautomaten, Ticketautomaten)
- E-Books und E-Reader-Software
- Software mit Nutzeroberfläche

**Technischer Standard:** WCAG 2.1 Level AA (+ WCAG 2.2 als aktuelle Empfehlung)

**Konformitätserklärung:** Betroffene Unternehmen müssen eine **Erklärung zur Barrierefreiheit** veröffentlichen.

**Sanktionen:** Marktüberwachungsbehörden (je Bundesland) können Bußgelder verhängen. Die genaue Bußgeldhöhe ist bundeslandabhängig. Strukturelle Nichteinhaltung ist als Ordnungswidrigkeit eingestuft.

### 1.2 BITV 2.0 als öffentlicher Sektor-Standard

Die **Barrierefreie-Informationstechnik-Verordnung (BITV 2.0)** gilt für Bundesbehörden und öffentliche Stellen. Sie ist strenger als BFSG (Level AA + zusätzliche DE-spezifische Anforderungen) und bereits seit 2019 verpflichtend. Öffentliche Auftraggeber haben damit einen zusätzlichen, seit Jahren bestehenden Compliance-Bedarf.

### 1.3 Warum der Markt jetzt entsteht

| Zeitpunkt | Entwicklung |
|---|---|
| Juni 2025 | BFSG-Pflicht tritt in Kraft |
| Q3 2025 | Erste Abmahnungen durch Wettbewerbsverbände |
| Q4 2025 | Marktüberwachung nimmt Fahrt auf |
| **2026** | **Unternehmen suchen aktiv nach Lösungen — wir sind jetzt hier** |
| 2027 | Markt gesättigt, Tool-Landschaft konsolidiert |

Das Zeitfenster für frühe Marktteilnehmer ist **jetzt, April bis Dezember 2026**.

---

## 2. Marktgröße & Segmentierung

### 2.1 Gesamtmarkt (TAM — Total Addressable Market)

| Segment | Anzahl DE | BFSG-betroffen | Zahlungsbereit |
|---|---|---|---|
| Websites mit E-Commerce | ~900.000 | ~700.000 | ~100.000 |
| Unternehmenswebsites (KMU) | ~3.500.000 | ~2.000.000 | ~200.000 |
| Mobile Apps (Stores DE) | ~180.000 Apps | ~80.000 | ~15.000 |
| Öffentliche Stellen (BITV) | ~15.000 | ~15.000 | ~8.000 |
| **Gesamt zahlungsbereite Unternehmen** | | | **~323.000** |

**TAM (DE, Gesamtmarkt):** ca. 97 Mio. Euro pro Jahr als theoretischer Gesamtmarkt aller betroffenen Unternehmen.

> Die Zahlen „betroffen" und „zahlt für ein Tool" dürfen nicht gleichgesetzt werden. Die Conversion von regulatorisch betroffenen Unternehmen zu zahlenden SaaS-Kunden liegt bei Compliance-Tools bei 0,1 bis 0,5 Prozent. Die realistische Zahlerbasis bei Direktvertrieb beträgt rund 650 bis 1.600 Unternehmen in DACH. Das ist ein valider Nischenmarkt, aber kein 97-Millionen-Markt.

**Der echte Zielmarkt: Berater als primäre Zahlungseinheit**

Der Endkunde prüft seine Website einmal im Jahr und zahlt kein Monatsabonnement. Der Berater nutzt das Tool bei jedem Kunden erneut und zahlt dauerhaft. Das Geschäftsmodell ist daher auf den Berater als Kernkunden ausgerichtet. Endkunden sind ein Pay-per-Use-Nebenkanal.

### 2.2 Serviceable Addressable Market (SAM)

Der MVP fokussiert auf IT-Berater und Agenturen, die BFSG-Audits als bezahlten Service durchführen. In DACH gibt es rund 12.000 IT-Beratungen mit Web- und App-Entwicklung, 8.000 Digital-Agenturen und rund 500 Barrierefreiheits-Spezialisten. Der adressierbare Markt für Berater-Abonnements beläuft sich auf rund 20.500 Unternehmen zu einem Durchschnittspreis von 99 bis 199 Euro pro Monat. Der Pay-per-Use-Kanal über Endkunden (rund 1.600 Käufer zu je 49 Euro pro Report) ist ein Nebenkanal.

### 2.3 Serviceable Obtainable Market (SOM) — Realistisch Jahr 1

Für das erste Jahr werden 30 bis 80 zahlende Berater-Abonnements sowie 50 bis 150 Pay-per-Use-Reports angestrebt. Das MRR-Ziel für Ende 2026 liegt zwischen 3.000 und 12.000 Euro. WAMOCON agiert selbst als erster Account und Referenzfall für die Berater-Akquise.

---

## 3. Wettbewerbsanalyse

### 3.1 Wettbewerbsmatrix

**Übersicht: Anbieter, Typ und Preis**

| Anbieter | Typ | Preis / Monat | DE/BFSG-Fokus |
|---|---|---|---|
| axe DevTools | Dev-Tool | $149 – $1.490 | Nein |
| WAVE (WebAIM) | Kostenlos/Web | Kostenlos | Nein |
| Siteimprove | Enterprise | €800 – €5.000 | Teilweise |
| Monsido | Enterprise | €500 – €3.000 | Nein |
| Userway | Widget | $49 – $490 | Nein |
| Silktide | SMB | $250 – $1.500 | Nein |
| Deque WorldSpace | Enterprise | Individuell | Nein |
| AccessibilityChecker | Freemium | Kostenlos | Nein |
| **AccessCheck (WAMOCON)** | **SaaS** | **€49 – €199** | **Ja (BFSG/BITV)** |

**Funktionsvergleich**

| Anbieter | Auto-Scan | Manueller Workflow | KI-Unterstützung | Report-Export |
|---|---|---|---|---|
| axe DevTools | Ja | Nein | Rudimentär | Eingeschränkt |
| WAVE (WebAIM) | Ja | Nein | Nein | Nein |
| Siteimprove | Ja | Teilweise | Teilweise | Ja |
| Monsido | Ja | Nein | Nein | Ja |
| Userway | Begrenzt | Nein | Nein | Nein |
| Silktide | Ja | Nein | Teilweise | Ja |
| Deque WorldSpace | Ja | Teilweise | Nein | Ja |
| AccessibilityChecker | Begrenzt | Nein | Nein | Nein |
| **AccessCheck (WAMOCON)** | **Welle 2** | **Ja (Kern)** | **Ja (Vision + Text)** | **Ja (PDF)** |

### 3.2 Strategische Lücken im Wettbewerb

**Lücke 1: Deutsche Regulatorik**
Kein Wettbewerber hat BFSG und BITV 2.0 als primären Standard implementiert. Alle Anbieter referenzieren WCAG, aber BFSG-spezifische Konformitätserklärungen, BITV-Prüfverfahren und deutschsprachige Berichte fehlen überall.

**Lücke 2: SMB-Preispunkt**
Der Markt ist zweigeteilt: kostenlose Tools ohne Workflow-Unterstützung stehen Enterprise-Tools ab 500 Euro pro Monat gegenüber. Der Bereich zwischen 49 und 199 Euro pro Monat für KMU und Berater ist unbesetzt.

**Lücke 3: KI-gestützte manuelle Prüfung**
Automatische Scanner erkennen rund 30 Prozent der WCAG-Verstöße. Kein Tool auf dem Markt unterstützt die manuelle Prüfung der verbleibenden 70 Prozent mit KI-Hilfe. Das ist der technische Differentiator von AccessCheck.

**Lücke 4: Berater-Workflow**
Bestehende Tools sind entweder auf Entwickler (axe) oder auf interne Enterprise-Compliance-Teams (Siteimprove) zugeschnitten. Kein Tool ist auf IT-Berater optimiert, die Audits als bezahlten Dienstleistungsservice anbieten.

### 3.3 Positionierungsaussage

> **AccessCheck halbiert die Zeit, die ein BFSG-Berater für einen vollständigen Audit benötigt: von 10 auf 4 Stunden. Der erzeugte Report ist professionell, vollständig und direkt an den Kunden verschickbar.**

Der Begriff „rechtssicherer Abschlussbericht" wird bewusst nicht verwendet, da er eine Rechtsgarantie impliziert und ein Haftungsrisiko darstellt.

**Warum Report-Qualität das Kernversprechen ist:**
Im Validierungsinterview sagte Berater Marcus H.: *„Zeig mir einen echten Report. Wenn der professionell aussieht, vollständig ist und ich ihn ohne Nacharbeit verschicken kann, dann bin ich dabei."* Der Berater kauft nicht die KI-Funktion. Er kauft Zeit zurück und professionelle Außenwirkung.

---

## 4. Zielgruppen & Personas

### Persona 1 — IT-Berater (Primär, validiert im Interview)

**Marcus, 41 Jahre, Senior IT-Consultant** in einer IT-Beratung mit 10 bis 50 Mitarbeitenden.

Marcus verbringt heute 8 bis 12 Stunden pro Audit: Excel-Checkliste, Word-Report, Screenshots manuell einpflegen, Formatierung. Allein die Report-Formatierung kostet ihn 3 Stunden. Er kann maximal 4 bis 6 Audits pro Jahr durchführen, obwohl die Nachfrage steigt.

Sein Ziel ist ein vollständiger, verschickbarer Auditbericht in 3 bis 4 Stunden. Er zahlt 99 bis 199 Euro pro Monat, wenn er mindestens 2 Audits pro Monat durchführt, und bevorzugt ansonsten Pay-per-Use für 49 Euro pro Report. Kein Feature-Pitch überzeugt ihn — nur eine Live-Demo mit einem echten Report.

Hauptrisiko: Er fürchtet KI-Fehler bei Grenzfällen (z. B. Kontrast 3,9:1 als „bestanden"), da diese ein Haftungsproblem für ihn darstellen.

### Persona 2 — Agentur-Owner (Sekundär)

**Sarah, 42 Jahre, Geschäftsführerin einer Digital-Agentur.**

Ihre Kunden fragen nach BFSG-Compliance, aber die Agentur hat noch kein strukturiertes Angebot. Sarah möchte BFSG-Audits als neues Dienstleistungspaket einführen. Zahlungsbereitschaft: 199 bis 299 Euro pro Monat für White-Label-Reports mit Agentur-Logo.

### Persona 3 — Compliance-Manager (Tertiär)

**Thomas, 51 Jahre, IT-Compliance in einem mittelständischen Unternehmen.**

Thomas muss intern nachweisen, dass digitale Produkte BFSG-konform sind. Er benötigt einen dokumentierten Audit-Trail und eine jährliche Wiederholungsprüfung. Zahlungsbereitschaft: 149 Euro pro Monat als Einzellizenz.

---

## 5. Monetarisierungsmodell

> **Kernkorrektur v1.1:** Das ursprüngliche reine Abo-Modell passt nicht zum Nutzungsverhalten. Endkunden prüfen 1×/Jahr — kein Abo. Berater prüfen mehrfach/Monat — Abo sinnvoll. Das Modell muss beide Cases bedienen.

### 5.1 Preismodell

| Plan | Preis | Zielgruppe |
|---|---|---|
| Pay-per-Report | 49 Euro / Report | Endkunden, Gelegenheitsnutzer |
| Berater Pro | 99 Euro / Monat | Freiberufliche Berater |
| Agentur Team | 199 Euro / Monat | Agenturen, kleine Beratungen |
| Studio | 349 Euro / Monat | Größere Teams |

**Pay-per-Report** beinhaltet einen vollständigen Audit mit PDF-Export ohne Abonnement oder Lock-in. **Berater Pro** umfasst unlimitierte Audits, PDF mit Logo sowie 50 KI-Analysen pro Monat. **Agentur Team** erweitert dies um 3 Nutzer, White-Label-Reports und 150 KI-Analysen. **Studio** bietet 10 Nutzer, unlimitierte KI-Analysen und Priority Support.

**Freemium-Gate:**
Der vollständige kostenlose Audit ist kein Freemium-Angebot, da er dem Endkunden den vollen Wert liefert ohne eine Zahlung auszulösen. Stattdessen gilt: Der Audit kann kostenlos durchgeführt werden, der PDF-Export ist erst nach Zahlung (49 Euro oder Abonnement) verfügbar. Eine Report-Vorschau im Browser zeigt die Qualität und motiviert zur Kaufentscheidung.

### 5.2 KI-Kostenstruktur

KI-Kosten müssen unter 12 Prozent des Umsatzes bleiben, damit die Pläne profitabel sind.

| Szenario | KI-Kosten | Umsatz | Anteil |
|---|---|---|---|
| Pay-per-Report, 50 KI-Analysen | ca. 2,50 Euro | 49 Euro | 5,1% |
| Berater Pro, 5 Audits/Monat | ca. 12,50 Euro | 99 Euro | 12,6% |
| Berater Pro, 10 Audits/Monat | ca. 25,00 Euro | 99 Euro | 25,3% |

Bei 10 Audits pro Monat im Berater-Pro-Plan ist das Modell nicht mehr tragbar. Daher sind KI-Analysen je Plan kontingentiert (50 / 150 / unlimitiert). Über das Kontingent hinaus kostet jede weitere Analyse 0,99 Euro pro 10 Analysen.

### 5.3 Zusatzumsatz

WAMOCON kann Audits als vollständigen Dienstleistungsauftrag selbst durchführen (Audit-as-a-Service) und dabei 800 bis 2.000 Euro pro Kundenaudit in Rechnung stellen. Die Tool-Kosten fallen intern an, die Marge verbleibt bei WAMOCON. Für Welle 2 sind zwei kostenpflichtige Add-ons geplant: ein DSGVO-Scan (39 Euro pro Report oder 29 Euro pro Monat) sowie ein automatischer axe-Rescan als Abo-Retention-Anker (19 Euro pro Monat).

### 5.4 Umsatzprojektion (revidiert — bootstrapped, realistisch)

| Zeitraum | Berater-Abos | Pay-per-Use Reports | MRR gesamt |
|---|---|---|---|
| Monat 1–2 (MVP) | 3 | 10 | ~€790 |
| Monat 3–6 | 20 | 40 | ~€3.960 |
| Monat 7–12 | 60 | 80 | ~€9.940 |
| Jahr 2 | 150 | 200 | ~€24.800 |

> Die vorherige Projektion von 55.650 Euro MRR mit 350 Accounts in Jahr 2 war ohne Vertriebsbudget nicht erreichbar und wurde gestrichen.

---

## 6. Go-to-Market Strategie

Feature-Pitches überzeugen Berater nicht. Der einzig funktionierende GTM-Einstieg ist eine Live-Demo mit einem echten Report an einer echten Website.

### Phase 0 — Vor dem Launch: Manuell validieren

Vor der ersten Codezeile werden 5 Berater aus dem WAMOCON-Netzwerk persönlich befragt. Das Interview klärt den aktuellen Prozess, den Zeitaufwand und den größten Frustrationspunkt. Die zentrale Frage lautet: „Würdest du 49 Euro für einen fertigen PDF-Report zahlen, der 6 Stunden Arbeit spart?" Das Ziel sind mindestens 2 schriftliche Zusagen für einen kostenlosen Pilot-Audit. Sollten diese nicht zustande kommen, wird die Produkthypothese überdacht.

### Phase 1 — WAMOCON als erster Anwender (Woche 1)

WAMOCON führt den ersten echten BFSG-Audit mit dem MVP an einer echten Kunden-Website durch. Das Ergebnis ist ein verschickbarer PDF-Report, der als Demo für alle weiteren Gespräche dient.

### Phase 2 — Live-Demo-Akquise (Monat 1 bis 2)

Bei 10 bis 15 Berater-Kontakten wird eine persönliche Demo durchgeführt: Eine echte Website wird live in 20 Minuten geprüft, der Report wird erzeugt und gezeigt. Es wird ausschließlich demonstriert, was heute funktioniert. Das Ziel sind 5 bis 10 zahlende Pilot-Accounts.

### Phase 3 — Content und SEO (Monat 3 bis 6)

Ein Unternehmensblog mit dem Thema „BFSG erklärt für KMU" adressiert eine hohe Suchintention bei gleichzeitig geringem Wettbewerb. Ein Lead-Magnet erlaubt, den Audit kostenlos zu starten und 10 Kriterien einzusehen. Der PDF-Export ist erst nach Zahlung verfügbar und zeigt die Report-Qualität vor dem Kauf. Auf LinkedIn werden echte anonymisierte Audit-Befunde mit Vorher-Nachher-Vergleichen veröffentlicht.

### Phase 4 — Partnerprogramm (ab Monat 6)

IT-Beratungen werden als Wiederverkäufer gewonnen. Sie erhalten White-Label-Reports mit eigenem Logo und eine Provision von 20 bis 25 Prozent auf Abo-Einnahmen über ihren Partnerlink.

---

# Teil II — Anforderungsdokumentation

---

## 7. Produktvision & Scope

### 7.1 Produktvision

> **AccessCheck halbiert die Zeit, die ein BFSG-Berater für einen vollständigen Audit benötigt: von 10 auf 4 Stunden. Der erzeugte PDF-Report ist professionell, vollständig und direkt an den Kunden verschickbar.**

Das Kernversprechen lautet nicht „KI-gestützte WCAG-Analyse", sondern „Report-fertig in 4 Stunden statt 10, direkt verschickbar."

**Haftungsrahmen:**
AccessCheck ist ein professionelles Prüfwerkzeug und kein Rechtsgutachten. KI-Analysen sind Empfehlungen. Die fachliche Beurteilung liegt beim Auditor. WAMOCON GmbH übernimmt keine Haftung für die Vollständigkeit oder Rechtsverbindlichkeit der erzeugten Reports.

**WAMOCON-Positionierung:**
WAMOCON startet AccessCheck ohne bestehende WCAG-Audit-Erfahrung. Das ist eine bewusste und transparente Entscheidung. Das Tool wird entwickelt, weil WAMOCON es selbst benötigt. Jede Funktion wird zuerst an eigenen Projekten getestet. Das Ergebnis ist ein Produkt, das am realen Arbeitsablauf ausgerichtet ist. Der stärkste Verkaufsbeweis ist: „Wir nutzen unser eigenes Tool täglich."

**Interner Doppelnutzen:**

| Nutzungskontext | Beschreibung |
|---|---|
| **Extern — Dienstleistung** | BFSG-Compliance-Audits als Service für Kunden (Berater-Persona) |
| **Intern — Qualitätssicherung** | Alle von WAMOCON entwickelten Webanwendungen werden zukünftig vor dem Launch mit AccessCheck auf WCAG 2.1 AA geprüft |

### 7.2 MVP-Scope (1 Woche, Einzelentwickler)

Das Projekt wird von einem einzelnen Entwickler ohne bestehendes Boilerplate komplett neu aufgebaut. KI-Features sind bewusst ausgegliedert und werden nach der Präsentation von einem separaten Entwicklungsteam in Phase 2 umgesetzt. Der PDF-Export erfolgt im MVP über den Browser-Druck (`window.print()` mit Print-CSS), ohne externen PDF-Generator.

**Im MVP-Scope (Phase 1):**

- Benutzeranmeldung mit E-Mail und Passwort
- Audit anlegen mit Kundenname, URL und Prüfdatum
- WCAG-Checkliste mit allen 50 Kriterien (Level A und AA, Deutsch)
- Schweregrad je Befund (Kritisch, Hoch, Mittel, Niedrig)
- Kommentarfelder und Screenshot-Upload je Kriterium
- Report-Export über Browser-Druck als sofort verschickbares PDF
- Dashboard mit allen Audits und Fortschrittsanzeige
- Berater-Logo im Report aus dem Nutzerprofil
- Landing Page als separates Deployment (Zeitaufwand ca. 1 Stunde)

**Außerhalb MVP-Scope — Phase 2 (KI-Team, nach MVP-Fertigstellung):**
- KI-Analyse von Screenshots (GPT-4o Vision)
- KI-Analyse von HTML/CSS-Code-Snippets
- KI-generierte Report-Zusammenfassung
- KI-Kontingent-Verwaltung

**Außerhalb MVP-Scope — Welle 2:**
- Zweisprachigkeit DE/EN (next-intl)
- In-App Handbuch mit Volltextsuche
- Automatischer axe-Browser-Scan
- Multi-User / Team-Accounts
- White-Label-Reports
- DSGVO-Scan-Integration
- **Chrome Companion Extension**

---

## 8. Funktionale Anforderungen

### 8.1 Authentifizierung & Nutzerverwaltung

| ID | Anforderung | Priorität |
|---|---|---|
| AUTH-01 | Registrierung mit E-Mail + Passwort | Muss |
| AUTH-02 | E-Mail-Bestätigung via Supabase | Muss |
| AUTH-03 | Login / Logout | Muss |
| AUTH-04 | Passwort-Reset per E-Mail | Muss |
| AUTH-05 | Nutzerprofil: Name, Firma, Logo-Upload | Soll |

### 8.2 Audit-Verwaltung

| ID | Anforderung | Priorität |
|---|---|---|
| AUD-01 | Neues Audit anlegen: Kundenname, Website-URL, Prüfdatum, Prüfer | Muss |
| AUD-02 | Audit-Status: Offen / In Prüfung / Abgeschlossen | Muss |
| AUD-03 | Dashboard: alle Audits mit Status, Datum, Kundennamen, Fertigstellungsgrad | Muss |
| AUD-04 | Audit löschen (mit Bestätigungsdialog) | Muss |
| AUD-05 | Audit duplizieren (für Folgeprüfungen) | Soll |
| AUD-06 | Notizfeld pro Audit (Freitext, intern) | Soll |

### 8.3 WCAG-Checkliste

| ID | Anforderung | Priorität |
|---|---|---|
| CHECK-01 | Vollständige WCAG 2.2 Level A Erfolgskriterien (30 Kriterien) | Muss |
| CHECK-02 | Vollständige WCAG 2.2 Level AA Erfolgskriterien (23 Kriterien) | Muss |
| CHECK-03 | Je Kriterium: Ergebnis (Bestanden / Fehlerhaft / Nicht anwendbar / Nicht geprüft) | Muss |
| CHECK-04 | Je Kriterium: Kommentarfeld (Freitext, beschreibt den Befund) | Muss |
| CHECK-05 | Je Kriterium: Schweregrad-Einschätzung (Kritisch / Hoch / Mittel / Niedrig) | Muss |
| CHECK-06 | Je Kriterium: Screenshot-Upload (max. 3 pro Kriterium) | Muss |
| CHECK-07 | Fortschrittsanzeige: X von Y Kriterien geprüft | Muss |
| CHECK-08 | Filterung: Nur Fehlgeschlagene / Nur Offene anzeigen | Soll |
| CHECK-09 | WCAG-Kurzerkärung je Kriterium (ausklappbar) | Soll |
| CHECK-10 | Automatisches Speichern alle 30 Sekunden | Muss |
| CHECK-11 | **Statischer Umsetzungshinweis** je fehlgeschlagenem Kriterium: vordefinierter Standard-Fix-Hinweis aus W3C-Spec, automatisch eingeblendet wenn Ergebnis = Fehlerhaft — in `wcag-criteria.ts` hinterlegt, kein KI nötig | Muss |

### 8.4 KI-Funktionen *(Phase 2 — Optionale Anforderungen)*

> **⚙️ Umsetzung durch separates Entwicklungsteam nach MVP-Fertigstellung.** Die untenstehenden Anforderungen sind vollständig spezifiziert und direkt übergabebereit. KI-Features sind **nicht** im 8-Stunden-MVP enthalten.

> **Leitprinzip KI (validiert):** KI ist Zeitersparnis-Werkzeug, kein Entscheidungsträger. Jede KI-Ausgabe ist explizit als "Vorschlag" markiert — der Auditor entscheidet immer. Das ist kein Funktionsmangel, sondern **aktiver Vertrauensaufbau** gegenüber Beratern mit Haftungsbedenken.

| ID | Anforderung | Priorität |
|---|---|---|
| KI-01 | **Screenshot-Analyse:** Screenshot hochladen → KI analysiert auf aktives Kriterium → Empfehlung (Bestanden/Fehlerhaft) mit Begründung und messbarem Wert wenn möglich (z.B. "Kontrast gemessen: 3,9:1 — Minimum: 4,5:1 → fehlerhaft") | Muss |
| KI-02 | **Code-Analyse:** HTML/CSS-Snippet eingeben → KI identifiziert Verstöße mit Fix-Vorschlag | Muss |
| KI-03 | KI-Antwort ist Empfehlung, nicht Urteil — Auditor bestätigt oder überschreibt mit einem Klick | Muss |
| KI-04 | KI-Antwort wird gespeichert (Audit-Trail: Zeitstempel, Kriterium, KI-Empfehlung, finale Auditor-Entscheidung) | Muss |
| KI-05 | **Sichtbarer Haftungshinweis:** Bei jeder KI-Analyse: "KI-Vorschlag — bitte fachlich bestätigen" — permanent sichtbar, nicht wegklickbar | Muss |
| KI-06 | **KI-Kontingent-Anzeige:** Verbleibende Analysen im Monat sichtbar im Dashboard, Warnung bei 10 verbleibenden | Muss |
| KI-07 | **Report-Zusammenfassung:** Alle Befunde → KI erzeugt Managementzusammenfassung in professionellem Deutsch, editierbar vor PDF-Export | Soll |
| KI-08 | Exakter Kontrastwert bei Kriterium 1.4.3 und 1.4.11 als Zahl im Report (nicht nur bestanden/fehlerhaft) | Soll |
| KI-09 | **Kontextbezogene Umsetzungshinweise:** KI ersetzt den statischen `fixHint` (CHECK-11) durch einen auf den konkreten Befund und Screenshot personalisierten Umsetzungsvorschlag, inkl. konkreter Code-Snippets wenn sinnvoll | Soll |

### 8.5 Report-Export

> **Höchste Priorität im MVP (Kundenvalidierung).** Der Report ist das Produkt das der Berater kauft — nicht die Checkliste. "Zeig mir einen echten Report" war die erste Antwort im Validierungsinterview. Report-Qualität entscheidet über Kauf oder Nicht-Kauf.

| ID | Anforderung | Priorität |
|---|---|---|
| REP-01 | PDF-Export des vollständigen Auditberichts — **direkt verschickbar ohne Nacharbeit in Word** | Muss |
| REP-02 | Report-Struktur: Deckblatt (Kunde, URL, Datum, Prüfer, Logo), Executive Summary, Bewertungsmatrix, Befundliste nach Schweregrad, Maßnahmenplan | Muss |
| REP-03 | Bewertungsmatrix: WCAG-Kriterium / Ergebnis / Schweregrad / Kommentar — gedruckt lesbar, tabellarisch | Muss |
| REP-04 | Befundliste: nur fehlgeschlagene Kriterien, mit Auditor-Kommentar + automatischem Umsetzungshinweis (aus `wcag-criteria.ts`) — nach Schweregrad sortiert (Kritisch zuerst) | Muss |
| REP-04a | **Maßnahmenplan:** Separate Report-Sektion, die alle fehlgeschlagenen Kriterien als Aufgabenliste darstellt: Kriterium / Schweregrad / Umsetzungshinweis — strukturiert für den Kunden als klare To-do-Liste | Muss |
| REP-05 | Berater-Logo und Firmenname im Report-Header (aus Nutzerprofil, einmalig hinterlegt) | Muss |
| REP-06 | **Pflicht-Disclaimer im Report-Footer:** "Dieser Bericht ist ein professionelles Prüfprotokoll und kein Rechtsgutachten. Die abschließende Beurteilung liegt beim Auftraggeber." | Muss |
| REP-07 | **Report-Vorschau im Browser** vor PDF-Export — Berater sieht exakt was der Kunde bekommt | Muss |
| REP-08 | **Report-Sprache wählbar:** DE oder EN — WCAG-Kriterien-Titel, Disclaimer und Zusammenfassung in gewählter Sprache | Muss |
| REP-09 | Screenshots der Befunde im Bericht eingebettet (inline unter dem jeweiligen Befund) | Soll |
| REP-10 | BFSG-Konformitätserklärung als separates ausfüllbares PDF-Template | Kann |

### 8.6 Mehrsprachigkeit (DE / EN)

> **Warum EN Pflicht ist:** Der EAA (European Accessibility Act) gilt EU-weit. Berater in Österreich, Schweiz und anderen EU-Ländern können das Tool nur nutzen wenn es auf Englisch verfügbar ist. Zudem erhöht EN-Verfügbarkeit die SEO-Reichweite erheblich.

> **Wichtige Einschränkung:** Zweisprachigkeit bedeutet nicht nur UI-Labels übersetzen. Alle 50 WCAG-Kriterien-Beschreibungen, alle KI-Prompts und alle PDF-Report-Texte müssen in beiden Sprachen korrekt und fachlich akkurat sein. Das ist der aufwändigste Teil (~6–8h Mehraufwand).

| ID | Anforderung | Priorität |
|---|---|---|
| I18N-01 | UI vollständig in DE und EN verfügbar via next-intl | Muss |
| I18N-02 | Sprachumschalter im Header (DE / EN), Einstellung wird gespeichert | Muss |
| I18N-03 | Alle 50 WCAG 2.2 Kriterien: Titel und Kurzbeschreibung in DE und EN | Muss |
| I18N-04 | KI-Prompts: Sprache dynamisch je Nutzersprache (DE-Antwort für DE-Nutzer, EN für EN-Nutzer) | Muss |
| I18N-05 | PDF-Report in gewählter Sprache generiert (Titel, Disclaimer, Zusammenfassung) | Muss |
| I18N-06 | Handbuch in DE und EN verfügbar | Soll |
| I18N-07 | Fehler- und Toast-Meldungen vollständig übersetzt | Muss |

### 8.7 In-App Handbuch *(Welle 2 — nach stabilem MVP-Kern)*

> **Umsetzung in Welle 2**, nicht im 8-Stunden-MVP. Das Handbuch wird nach stabilem MVP-Kern und erster Nutzervalidierung ergänzt.

> **Vorbild:** Das WAMOCON Energieberater-Projekt hat ein 11-seitiges Handbuch mit Volltextsuche und PDF-Export — dieses Pattern wird übernommen und erweitert.

| ID | Anforderung | Priorität |
|---|---|---|
| HB-01 | In-App Handbuch erreichbar über Navigation (eigene Seite `/handbook`) | Muss |
| HB-02 | Volltextsuche im Handbuch — Ergebnisse werden bei Eingabe live gefiltert | Muss |
| HB-03 | Handbuch-Struktur: Abschnitte je Feature (Audit anlegen, Checkliste ausfüllen, KI nutzen, Report exportieren, etc.) | Muss |
| HB-04 | PDF-Download des vollständigen Handbuchs via Browser-Druck (kein separater PDF-Generator nötig) | Muss |
| HB-05 | Handbuch in DE und EN (je nach App-Sprache) | Soll |
| HB-06 | Direktlinks aus der App ins Handbuch ("?" Icon je Funktion → springt zur passenden Handbuch-Sektion) | Kann |

### 8.8 Landing Page *(Separates Deployment — 1h Ziel)*

> **Technischer Ansatz:** Statische `index.html`-Datei mit Tailwind CSS CDN, deployed als separates Vercel-Projekt. Kein Build-Prozess, kein Framework — maximale Einfachheit für minimalen Zeitaufwand.

| ID | Anforderung | Priorität |
|---|---|---|
| LP-01 | Hero-Section: Headline, Sub-Headline, primärer CTA ("Jetzt kostenlos testen") | Muss |
| LP-02 | Pain-Section: 3 konkrete Berater-Probleme (Zeit, Report-Formatierung, fehlende DE-Tools) | Muss |
| LP-03 | Solution-Preview: Screenshot oder Mockup des fertigen Reports | Muss |
| LP-04 | CTA-Link zur Web-App (Registrierung) | Muss |
| LP-05 | Responsiv (Mobile-First, Tailwind CDN) | Muss |
| LP-06 | Impressum + Datenschutzhinweis (DSGVO-Pflicht, Link oder Inline) | Muss |
| LP-07 | Berater-Testimonial (aus Validierungsinterview) | Soll |

---

## 9. Nicht-Funktionale Anforderungen

| ID | Anforderung | Zielwert |
|---|---|---|
| NF-01 | **Performance:** Seitenlade-Zeit < 2 Sekunden | < 2s |
| NF-02 | **KI-Antwortzeit:** Screenshot-Analyse < 15 Sekunden | < 15s |
| NF-03 | **Datenschutz:** Hochgeladene Screenshots DSGVO-konform gespeichert, EU-Server | Pflicht |
| NF-04 | **Datenschutz:** Keine Weitergabe von Upload-Daten an KI-Trainingsdaten | Pflicht |
| NF-05 | **Responsiveness:** Vollständig nutzbar auf Desktop (1280px+) und Tablet (768px+) | Pflicht |
| NF-06 | **Sicherheit:** Row-Level Security — jeder Nutzer sieht nur eigene Audits | Pflicht |
| NF-07 | **Verfügbarkeit:** 99% Uptime (Vercel + Supabase) | 99% |
| NF-08 | **Barrierefreiheit des Tools selbst:** Das Audit-Tool ist selbst WCAG 2.1 AA konform | Soll |
| NF-09 | **Offline-Funktionalität:** App funktioniert online und offline — PWA (Progressive Web App) mit Service Worker und lokalem Datenspeicher (IndexedDB) | Pflicht |
| NF-10 | **Offline-Scope:** Bestehende Audits lesen, Checkliste ausfüllen + lokal speichern, neues Audit anlegen, Report als PDF exportieren (Browser-Print) — alles ohne Internetverbindung nutzbar | Pflicht |
| NF-11 | **Offline-Sync:** Lokal gespeicherte Änderungen werden automatisch mit Supabase synchronisiert wenn die Internetverbindung wieder verfügbar ist (Background Sync) | Pflicht |
| NF-12 | **PWA-Installierbarkeit:** App kann auf Desktop und Mobilgerät als installierte App gespeichert werden (Web App Manifest + Service Worker) | Pflicht |
| NF-13 | **Erwartete Nutzerzahl (MVP):** < 100 gleichzeitige Nutzer in MVP-Phase (Ziel: 30–80 Berater-Abos Ende 2026) | < 100 |
| NF-14 | **Bevorzugter Kommunikationskanal mit Nutzern:** E-Mail (Transaktionsmails via Supabase Auth, Onboarding-Mails) | E-Mail |

---

## 9a. Design & UX-Anforderungen

| Attribut | Entscheidung | Begründung |
|---|---|---|
| **Visueller Stil** | Modern / Minimal | Professionelles Tool-Design für Berater — keine konsumorientierten UI-Muster. Cleane Tabellen, viel Weißraum, klare Typografie |
| **Design-Referenz** | Keine konkrete Referenz vorgegeben | Orientierung an etablierten SaaS-Tool-Patterns (Dashboard-Layouts mit Seitennavigation) |
| **Dunkelmodus** | Optional — nicht im MVP | Kann in Welle 2 ergänzt werden; MVP ausschließlich Light Mode |
| **Primärfarbe** | WAMOCON Brand-Farben | Konsistenz mit bestehendem WAMOCON-Auftritt |
| **Priorität MVP** | Geschwindigkeit vor perfektem Styling | Funktionierender Kernprozess in 1 Woche hat Vorrang — kein Over-Engineering der UI |

---

## 9b. Projektrahmen

| Attribut | Wert |
|---|---|
| **Projektname** | AccessCheck |
| **Entwickler** | Einzelentwickler (WAMOCON intern) |
| **Entwicklungsbudget** | Kein explizites Budget definiert — Eigenentwicklung, laufende Kosten: Supabase Free Tier + Vercel Hobby (kostenlos im MVP), OpenAI API erst ab Phase 2 |
| **Deadline** | Ende Woche 1 (5 Arbeitstage ab Projektstart) |
| **Priorität** | Geschwindigkeit — funktionierender MVP in 1 Woche hat Vorrang vor vollständigem Feature-Set |
| **Bestehende App/Website** | Keine — Neuprojekt. Landing Page als separates Deployment |
| **Kommunikation mit Nutzern** | E-Mail (Supabase Auth für Transaktionsmails) |

---

## 10. Technischer Stack & Architektur

### 10.1 Stack

| Ebene | Technologie | Begründung |
|---|---|---|
| **Frontend** | Next.js 16 (App Router), TypeScript, Tailwind CSS v4 | Entspricht bestehendem WAMOCON-Stack |
| **Backend/DB** | Supabase (PostgreSQL, Auth, Storage, RLS) | Bewährt, DSGVO-konform, EU-Server |
| **Offline-Speicher** | IndexedDB via `Dexie.js` | Strukturierter lokaler Datenspeicher für Audits + Findings; leichtgewichtig, TypeScript-native |
| **PWA** | `next-pwa` (Workbox-basiert) | Service Worker + App Manifest, Offline-Caching, installierbar |
| **Offline-Sync** | Custom Sync-Layer (Dexie → Supabase) | Erkennt Online-Status, synchronisiert ausstehende Änderungen automatisch |
| **KI** | OpenAI GPT-4o (Vision + Text) via API | State-of-the-Art Vision-Analyse, stabile API (Phase 2) |
| **PDF-Export** | Browser-Print (`window.print()` + Print-CSS) | Funktioniert offline, kein externer Dienst nötig |
| **Internationalisierung** | `next-intl` | Bereits im WAMOCON-Stack bekannt (Energieberater-Projekt) |
| **Deployment Web-App** | Vercel | CI/CD, Edge-Network, Zero-Config |
| **Deployment Extension** | Chrome Web Store (Welle 2) | Separater Build-Prozess mit Manifest V3 |

> **Architekturhinweis Offline-Sync:** Die Kombination Offline-First und Supabase erfordert einen sorgfältig implementierten Sync-Layer. Als Konfliktstrategie wird Last-Write-Wins mit `updated_at`-Timestamp-Vergleich eingesetzt. Das ist die einfachste umsetzbare Strategie für den MVP. Der Sync-Layer ist der technisch anspruchsvollste Teil und sollte als erster Baustein gebaut und getestet werden.

### 10.2 Datenbankschema

**Tabelle: profiles**

| Feld | Typ | Beschreibung |
|---|---|---|
| id | uuid (PK) | Referenz auf auth.users |
| full_name | text | Vollständiger Name |
| company_name | text | Firmenname |
| logo_url | text | Pfad in Supabase Storage |
| created_at | timestamptz | Erstellungsdatum |

**Tabelle: audits**

| Feld | Typ | Beschreibung |
|---|---|---|
| id | uuid (PK) | Automatisch generiert |
| user_id | uuid (FK) | Referenz auf profiles |
| client_name | text | Kundenname (Pflichtfeld) |
| website_url | text | Geprüfte URL |
| audit_date | date | Prüfdatum (Pflichtfeld) |
| auditor_name | text | Name des Prüfers |
| status | text | open / in_progress / completed |
| report_language | text | de / en (Standard: de) |
| notes | text | Interne Notizen |
| created_at / updated_at | timestamptz | Zeitstempel |

**Tabelle: audit_findings**

| Feld | Typ | Beschreibung |
|---|---|---|
| id | uuid (PK) | Automatisch generiert |
| audit_id | uuid (FK) | Referenz auf audits |
| wcag_criterion | text | Kriterium, z.B. „1.1.1" |
| wcag_level | text | A, AA oder AAA |
| result | text | passed / failed / na / not_checked |
| severity | text | critical / high / medium / low |
| comment | text | Auditor-Kommentar |
| ai_suggestion | text | Gespeicherte KI-Antwort |
| ai_used | boolean | Wurde KI verwendet? |

**Tabelle: finding_screenshots**

| Feld | Typ | Beschreibung |
|---|---|---|
| id | uuid (PK) | Automatisch generiert |
| finding_id | uuid (FK) | Referenz auf audit_findings |
| storage_path | text | Pfad in Supabase Storage |
| ai_analysis | text | KI-Analyse des Screenshots |
| created_at | timestamptz | Hochladezeitpunkt |

Row-Level Security: Die Spalte `user_id = auth.uid()` auf der Tabelle `audits` stellt sicher, dass jeder Nutzer ausschließlich seine eigenen Daten sieht. Alle abhängigen Tabellen erben die Zugriffsbeschränkung über JOIN-Beziehungen.

### 10.3 App-Struktur (Next.js App Router)

| Pfad | Beschreibung |
|---|---|
| `app/(auth)/login` | Login-Seite |
| `app/(auth)/register` | Registrierung |
| `app/(auth)/forgot-password` | Passwort-Reset |
| `app/(dashboard)/page.tsx` | Dashboard: Audit-Übersicht |
| `app/(dashboard)/layout.tsx` | Sidebar und Navigation |
| `app/(dashboard)/audits/new` | Neues Audit anlegen |
| `app/(dashboard)/audits/[id]` | Audit-Detail und Fortschritt |
| `app/(dashboard)/audits/[id]/checklist` | WCAG-Checkliste |
| `app/(dashboard)/audits/[id]/report` | Report-Vorschau und PDF-Export |
| `app/(dashboard)/settings` | Profil und Logo-Upload |
| `app/api/` | API-Routen (Phase 2: KI, PDF) |
| `lib/wcag-criteria.ts` | 50 WCAG 2.2 Kriterien inkl. fixHint (statisch, DE) |

**Datenstruktur `wcag-criteria.ts`** — jedes Kriterium enthält folgende Felder: `id` (z.B. „1.1.1"), `level` (A oder AA), `title` (Kurzname Deutsch), `description` (W3C-Kurzbeschreibung), `fixHint` (statischer Umsetzungshinweis aus der W3C-Spec) sowie `principle` (perceivable / operable / understandable / robust).

### 10.4 KI-Integrationsarchitektur (Phase 2)

Der Berater lädt einen Screenshot hoch. Die Datei wird verschlüsselt auf dem EU-Supabase-Server gespeichert. Die API-Route `ai/analyze-screenshot` lädt das Bild über eine temporäre Signed URL (60 Sekunden Ablauf), baut einen WCAG-spezifischen Prompt auf und sendet ihn an die OpenAI GPT-4o Vision API. Die Antwort enthält Ergebnis (bestanden/fehlerhaft), Begründung, konkreten Befund und Umsetzungsempfehlung. Sie wird in der Datenbank gespeichert und im UI angezeigt.

API-Schlüssel werden ausschließlich serverseitig in `.env` gehalten und sind niemals im Client verfügbar.

---

## 10.5 Chrome Companion Extension (Welle 2)

### Entscheidung: Companion, kein Standalone

Eine vollständige Chrome Extension als eigenständiges Produkt würde einen separaten Tech-Stack, eigene Auth-Logik und einen eigenen PDF-Generator erfordern — das wäre ein zweites Projekt. Stattdessen: eine **schlanke Companion Extension** (~200 Zeilen JS) die den Scan beschleunigt und den Rest an die Web-App übergibt.

### Architektur der Chrome Extension

Die Extension injiziert axe-core in den aktiven Browser-Tab und führt einen automatischen Scan durch. Die gefundenen Verstöße (WCAG-Kriterium, betroffenes Element, Beschreibung) werden gesammelt und per API-Call an die AccessCheck Web-App übergeben. Die Web-App erstellt daraus automatisch ein neues Audit mit vorausgefüllter Checkliste. Der Berater vervollständigt die manuelle Prüfung und exportiert den Report.

### Vorteile dieses Ansatzes

| Vorteil | Erklärung |
|---|---|
| **Kein Duplizierten Code** | Extension macht nur Scan, Web-App macht alles andere |
| **Chrome Web Store Präsenz** | Kostenlose Extension = Distributions-Kanal und SEO-äquivalent im Store |
| **Echter Mehrwert** | axe-core direkt im Live-DOM — erkennt dynamisch generierte Inhalte die Screenshots nicht zeigen |
| **Schneller Einstieg für Berater** | Kein manuelles URL-Eingeben — Extension liest aktive Tab-URL |

### Extension-Anforderungen (Welle 2)

| ID | Anforderung | Priorität |
|---|---|---|
| EXT-01 | Manifest V3-konforme Chrome Extension | Muss |
| EXT-02 | Toolbar-Icon mit Popup: "Scan starten" Button | Muss |
| EXT-03 | axe-core in aktiven Tab injizieren, Scan durchführen | Muss |
| EXT-04 | Scan-Ergebnisse an AccessCheck Web-App übergeben (URL-Parameter oder API) | Muss |
| EXT-05 | Neues Audit in Web-App automatisch anlegen mit Scan-Ergebnissen vorausgefüllt | Muss |
| EXT-06 | Extension erkennt ob Nutzer eingeloggt ist (AccessCheck Session) | Soll |
| EXT-07 | Chrome Web Store Veröffentlichung (kostenlos, als WAMOCON-Tool) | Muss |
| EXT-08 | Firefox Add-on Portierung (Manifest V3 meist kompatibel) | Kann |

### Was die Extension NICHT macht
- Kein vollständiger Audit in der Extension
- Kein PDF-Export in der Extension
- Keine manuelle Checkliste in der Extension
- Keine eigene Auth — nutzt Web-App Session

---

## 11. WCAG 2.2 Kriterien-Katalog (MVP-Umfang)

### Level A — 30 Kriterien (Pflicht)

| ID | Kriterium | Bereich |
|---|---|---|
| 1.1.1 | Nicht-Text-Inhalt | Wahrnehmbar |
| 1.2.1 | Nur-Audio und Nur-Video (aufgezeichnet) | Wahrnehmbar |
| 1.2.2 | Untertitel (aufgezeichnet) | Wahrnehmbar |
| 1.2.3 | Audiodeskription oder Medienalternative | Wahrnehmbar |
| 1.3.1 | Info und Beziehungen | Wahrnehmbar |
| 1.3.2 | Bedeutungsvolle Reihenfolge | Wahrnehmbar |
| 1.3.3 | Sensorische Eigenschaften | Wahrnehmbar |
| 1.4.1 | Verwendung von Farbe | Wahrnehmbar |
| 1.4.2 | Audio-Steuerung | Wahrnehmbar |
| 2.1.1 | Tastatur | Bedienbar |
| 2.1.2 | Keine Tastaturfalle | Bedienbar |
| 2.1.4 | Zeichentasten-Tastaturkürzel | Bedienbar |
| 2.2.1 | Zeitlimits anpassen | Bedienbar |
| 2.2.2 | Pausieren, Stoppen, Ausblenden | Bedienbar |
| 2.3.1 | Grenzwert von dreimaligem Aufblitzen | Bedienbar |
| 2.4.1 | Blöcke umgehen | Bedienbar |
| 2.4.2 | Seite mit Titel versehen | Bedienbar |
| 2.4.3 | Fokus-Reihenfolge | Bedienbar |
| 2.4.4 | Linkzweck (im Kontext) | Bedienbar |
| 2.5.1 | Zeigergesten | Bedienbar |
| 2.5.2 | Abbruch von Zeigereingaben | Bedienbar |
| 2.5.3 | Beschriftung im Namen | Bedienbar |
| 2.5.4 | Bewegungsaktivierung | Bedienbar |
| 3.1.1 | Sprache der Seite | Verständlich |
| 3.2.1 | Bei Fokus | Verständlich |
| 3.2.2 | Bei Eingabe | Verständlich |
| 3.3.1 | Fehlererkennung | Verständlich |
| 3.3.2 | Beschriftungen oder Anweisungen | Verständlich |
| 4.1.1 | Syntaxanalyse (obsolet in 2.2, aber für Rückwärtskompatibilität) | Robust |
| 4.1.2 | Name, Rolle, Wert | Robust |

### Level AA — 23 Kriterien (Pflicht für BFSG-Konformität)

| ID | Kriterium | Bereich |
|---|---|---|
| 1.2.4 | Untertitel (live) | Wahrnehmbar |
| 1.2.5 | Audiodeskription (aufgezeichnet) | Wahrnehmbar |
| 1.3.4 | Bildschirmausrichtung | Wahrnehmbar |
| 1.3.5 | Eingabezweck bestimmen | Wahrnehmbar |
| 1.4.3 | Kontrastverhältnis (Minimum) | Wahrnehmbar |
| 1.4.4 | Textgröße ändern | Wahrnehmbar |
| 1.4.5 | Bilder von Text | Wahrnehmbar |
| 1.4.10 | Umbruch bei Zoom | Wahrnehmbar |
| 1.4.11 | Nicht-Text-Kontrast | Wahrnehmbar |
| 1.4.12 | Textabstand | Wahrnehmbar |
| 1.4.13 | Inhalt bei Hover oder Fokus | Wahrnehmbar |
| 2.4.5 | Verschiedene Methoden | Bedienbar |
| 2.4.6 | Überschriften und Beschriftungen | Bedienbar |
| 2.4.7 | Fokus sichtbar | Bedienbar |
| 2.4.11 | Fokus nicht verdeckt (Minimum) | Bedienbar |
| 2.5.7 | Ziehbewegungen | Bedienbar |
| 2.5.8 | Zielgröße (Minimum) | Bedienbar |
| 3.1.2 | Sprache von Teilen | Verständlich |
| 3.2.3 | Konsistente Navigation | Verständlich |
| 3.2.4 | Konsistente Erkennung | Verständlich |
| 3.3.3 | Fehlerempfehlung | Verständlich |
| 3.3.4 | Fehlervermeidung (rechtlich, finanziell, Daten) | Verständlich |
| 4.1.3 | Statusmeldungen | Robust |

---

## 12. Implementierungsplan — 1 Woche (Einzelentwickler, Projekt von Null)

> **Grundannahmen:**
> - Einzelentwickler, kein bestehendes Boilerplate — Projekt wird komplett neu aufgesetzt
> - Kein KI im MVP — KI-Features Phase 2 (separates Team, nach Präsentation)
> - PDF-Export: Browser-Print (`window.print()` + Print-CSS) — kein react-pdf, kein puppeteer
> - Sprache: Deutsch (DE) im MVP; EN als Welle 2
> - App Router Next.js 16, Supabase, Tailwind CSS v4

---

### Tag 1 — 8h-MVP: Fundament bis verschickbarer Report

> **Ziel:** Am Ende von Tag 1 existiert eine lauffähige App. Audit anlegen → Checkliste ausfüllen → Report als PDF drucken. Kein KI, kein i18n, kein Handbuch — nur der Kernprozess.

**Stunde 1–1,5 — Projekt-Setup**
- [ ] `npx create-next-app@latest` mit TypeScript, Tailwind CSS v4, App Router
- [ ] Supabase-Projekt erstellen, `NEXT_PUBLIC_SUPABASE_URL` + `NEXT_PUBLIC_SUPABASE_ANON_KEY` in `.env.local`
- [ ] GitHub Repository + Vercel-Verbindung, ersten Deploy verifizieren

**Stunde 1,5–3 — Datenbank & Auth**
- [ ] Supabase-Schema migrieren: `profiles`, `audits`, `audit_findings`, `finding_screenshots`
- [ ] RLS-Policies: `user_id = auth.uid()` auf `audits`
- [ ] Auth-Flow: Login, Registrierung, Logout (Supabase Auth)
- [ ] Route-Schutz: Middleware — `/dashboard/**` nur für eingeloggte Nutzer

**Stunde 3–4,5 — Audit-Verwaltung**
- [ ] Dashboard (`/dashboard`): Liste aller Audits mit Name, URL, Status, Fertigstellungsgrad
- [ ] Audit anlegen (`/dashboard/audits/new`): Kundenname, URL, Prüfdatum — Formular + Supabase Insert
- [ ] Audit löschen: Bestätigungsmodal + Supabase Delete

**Stunde 4,5–7 — WCAG-Checkliste**
- [ ] `src/lib/wcag-criteria.ts`: alle 50 WCAG 2.2 A+AA Kriterien als statisches Array (DE, aus offizieller W3C-Spec) — je Kriterium: `id`, `level`, `title`, `description`, `fixHint`, `principle`
- [ ] Checklisten-Seite (`/dashboard/audits/[id]/checklist`): gruppiert je WCAG-Prinzip (Wahrnehmbar / Bedienbar / Verständlich / Robust)
- [ ] Je Kriterium: Ergebnis-Buttons (Bestanden / Fehlerhaft / Nicht anwendbar), Kommentarfeld, Schweregrad-Auswahl
- [ ] Supabase Upsert bei jeder Änderung + Autosave alle 30s
- [ ] Fortschrittsbalken: X von 50 geprüft

**Stunde 7–8 — Report-Export (Browser-Print)**
- [ ] Report-Seite (`/dashboard/audits/[id]/report`): Deckblatt, Zusammenfassung, Bewertungs-Tabelle, Befundliste nach Schweregrad
- [ ] Print-CSS (`@media print`): saubere Seitenumbrüche, lesbare Tabellen, Navigation ausgeblendet
- [ ] Disclaimer-Footer: "Dieser Bericht ist ein professionelles Prüfprotokoll und kein Rechtsgutachten."
- [ ] "Als PDF speichern"-Button → `window.print()`

**✅ Deliverable Ende Tag 1:** Vollständiger MVP lauffähig — Audit anlegen → Checkliste ausfüllen → Report per Browser-Print als PDF speichern

---

### Tag 2 — Vollständigkeit & Berater-Branding

- [ ] Nutzerprofil-Seite: Firmenname + Logo-Upload (Supabase Storage)
- [ ] Report-Deckblatt: Berater-Logo + Firmenname aus Profil
- [ ] Screenshot-Upload je Befund (max. 3 pro Kriterium, Supabase Storage, signed URLs)
- [ ] Screenshots inline im Report eingebettet (unter jeweiligem Befund)
- [ ] WCAG-Kurzerläuterung je Kriterium (ausklappbares Info-Feld)
- [ ] Checklisten-Filter: Nur Fehlgeschlagene / Nur Offene anzeigen
- [ ] Audit-Status verwalten: Offen → In Prüfung → Abgeschlossen

**✅ Deliverable Ende Tag 2:** Report mit Berater-Logo, Screenshots, vollständigen Befunddetails

---

### Tag 3 — Qualitätssicherung & Stabilität

- [ ] End-to-End-Test: vollständigen fiktiven BFSG-Audit durchführen (alle 50 Kriterien, mit Screenshots)
- [ ] Report-Qualitäts-Check: "Würde ich diesen Report ohne Nacharbeit an einen Kunden schicken?"
- [ ] Responsiveness: Desktop (1280px+) und Tablet (768px+) verifizieren
- [ ] Security-Review: RLS-Policies testen, Server-only API-Keys, Signed URLs für Storage
- [ ] Edge-Cases: leerer Report, Audit ohne Befunde, langer Kundenname
- [ ] `npm run typecheck` → `npm run lint` → `npm run build` — keine Fehler

**✅ Deliverable Ende Tag 3:** Stabile, bug-freie App — bereit für echten ersten Audit

---

### Tag 4 — Landing Page (1h) + Produktions-Deployment

**[1h—Ziel] Landing Page — Separates Vercel-Projekt**
- [ ] Statische `index.html` mit Tailwind CSS CDN aufsetzen
- [ ] Struktur: Hero (Headline + CTA), Pain-Points (Zeit/Report/DE-Fokus), Report-Screenshot, Footer mit Impressum
- [ ] Separates GitHub Repo + Vercel Deploy → URL verifizieren

**Restlicher Tag 4 — Produktions-Deployment der App**
- [ ] Produktions-Umgebungsvariablen in Vercel konfigurieren (Supabase, keine `.env.local`)
- [ ] Custom Domain einrichten (falls vorhanden)
- [ ] Finaler Build: `npm run build` — keine TypeScript/Lint-Fehler
- [ ] Erste echte Nutzungssession auf Produktions-URL

**✅ Deliverable Ende Tag 4:** App + Landing Page live auf Vercel

---

### Tag 5 — Präsentation & Übergabe Phase 2

- [ ] Ersten vollständigen echten BFSG-Audit mit AccessCheck durchführen (eigene oder bekannte Test-URL)
- [ ] Report exportieren — ist er professionell, direkt verschickbar?
- [ ] Präsentation vorbereiten: **Live-Demo statt Foliendeck** — echte URL live in 20 Minuten prüfen, Report zeigen
- [ ] Offene Bugs aus Bug-Log schließen
- [ ] KI-Anforderungen (Section 8.4) als Übergabedokument für Phase-2-Team bereitstellen

**✅ Deliverable Ende Tag 5:** Präsentationsreife App mit echtem erstem Audit als Demo, Phase-2-Übergabe vorbereitet

---

### App-Struktur MVP (Next.js 16 App Router)

| Pfad | Beschreibung |
|---|---|
| `app/(auth)/login` | Login-Seite |
| `app/(auth)/register` | Registrierung |
| `app/(auth)/forgot-password` | Passwort-Reset |
| `app/(dashboard)/page.tsx` | Dashboard: Audit-Übersicht |
| `app/(dashboard)/layout.tsx` | Sidebar und Navigation |
| `app/(dashboard)/audits/new` | Neues Audit anlegen |
| `app/(dashboard)/audits/[id]` | Audit-Detail und Fortschritt |
| `app/(dashboard)/audits/[id]/checklist` | WCAG-Checkliste |
| `app/(dashboard)/audits/[id]/report` | Report-Vorschau und Druck |
| `app/(dashboard)/settings` | Profil und Logo-Upload |
| `lib/wcag-criteria.ts` | 50 WCAG 2.2 Kriterien statisch, DE |
| `lib/supabase/client.ts` | Supabase Browser-Client |
| `lib/supabase/server.ts` | Supabase Server-Client |


---

## 13. Risiken & Mitigationen

| Risiko | Wahrscheinlichkeit | Impact |
|---|---|---|
| Offline-Sync-Komplexität | Hoch | Hoch |
| Fehlende WCAG-Domainerfahrung | Sicher | Mittel |
| 8h-Plan zu eng (von Null) | Mittel | Mittel |
| PDF via Browser-Print unzureichend | Niedrig | Mittel |
| WCAG-Kriterien-Datei unvollständig | Niedrig | Hoch |
| Supabase Storage DSGVO | Niedrig | Hoch |
| KI-Kosten (Phase 2) | Mittel | Mittel |

**Mitigationsmaßnahmen im Detail**

**Offline-Sync-Komplexität:** Der Sync-Layer wird als erster Baustein gebaut und isoliert getestet, bevor die UI entwickelt wird. Konfliktstrategie: Last-Write-Wins mit `updated_at`. Bei Zeitdruck wird der Offline-Scope auf Lesen und Checkliste-Ausfüllen reduziert; Anlegen und Sync folgen in Welle 2.

**Fehlende WCAG-Domainerfahrung:** Alle 50 Kriterien-Beschreibungen werden direkt aus der offiziellen W3C WCAG 2.2 Spec übernommen. Der erste interne Audit an Tag 5 deckt Wissenslücken vor dem Kundeneinsatz auf.

**8h-Plan zu eng:** Browser-Print statt react-pdf spart 2 bis 3 Stunden. Screenshot-Upload wird auf Tag 2 verschoben, nicht Tag 1.

**PDF via Browser-Print unzureichend:** Print-CSS mit `@page`-Regeln, Testdruck in Chrome und Edge vor der Präsentation. Der Berater speichert über „Als PDF drucken" — ein etablierter Workflow.

**WCAG-Kriterien-Datei unvollständig:** Vollständigkeit der 50 Kriterien wird vor Tag 2 anhand der W3C Quick Reference verifiziert.

**Supabase Storage DSGVO:** EU-Supabase-Region Frankfurt wird verwendet und in der Datenschutzerklärung der Landing Page dokumentiert.

**KI-Kosten Phase 2:** KI-Kontingentierung je Plan ist in Section 5.2 spezifiziert. Bei der Phase-2-Übergabe wird die Kostenrechnung mit aktuellen OpenAI-Preisen validiert.

---

## 14. Erfolgskriterien

### MVP-Kriterien — Freigabe-Präsentation (Ende Woche 1)

| Kriterium | Zielwert |
|---|---|
| App + Landing Page live auf Vercel | Ende Tag 4 |
| Vollständiger erster BFSG-Audit abgeschlossen | Ende Tag 5 |
| Report ohne Nacharbeit verschickbar | Tag 5 — Selbst-Check: "Würde ich das an einen Kunden schicken?" |
| `typecheck` + `lint` + `build` — keine Fehler | Vor Präsentation |
| RLS-Policies verifiziert (andere Nutzer sehen keine fremden Audits) | Tag 3 |
| KI-Anforderungen als Übergabedokument für Phase-2-Team bereit | Tag 5 |

### Markt-KPIs (nach Freigabe)

| Kriterium | Zielwert |
|---|---|
| Erster externer Pilot-Audit (Berater) | Woche 2 nach Launch |
| Erster bezahlter Account | Woche 4 nach Launch |
| MRR-Ziel Ende 2026 | €3.000–€12.000/Monat |
| Zeitersparnis je Audit vs. manuell | ≤ 4h statt 10h |
| Net Promoter Score (intern, nach erstem echten Audit) | ≥ 8/10 |

### Phase-2-KPIs (nach KI-Integration durch separates Team)

| Kriterium | Zielwert |
|---|---|
| KI-Analyse-Genauigkeit (Screenshot) | ≥ 80% Übereinstimmung mit Auditor-Urteil |
| KI-Antwortzeit | < 15 Sekunden |
| KI-Kostenanteil an Umsatz | < 12% |

---

*Dokument: AccessCheck — BFSG Audit Tool | WAMOCON GmbH | April 2026*
