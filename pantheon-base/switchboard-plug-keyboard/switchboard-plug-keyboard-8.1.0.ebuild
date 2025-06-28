# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Adjust keyboard settings from Switchboard"
HOMEPAGE="https://github.com/elementary/settings-keyboard"
SRC_URI="https://github.com/elementary/settings-keyboard/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64"

RDEPEND="
	app-i18n/ibus
	gui-libs/libadwaita:1
	dev-libs/glib:2
	dev-libs/granite:7
	dev-libs/libxml2
	pantheon-base/switchboard:3
	gui-libs/gtk:4
"

DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

S="${WORKDIR}/settings-keyboard-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}
