# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Adjust Locale settings using Switchboard."
HOMEPAGE="https://github.com/elementary/switchboard-plug-locale"
SRC_URI="https://github.com/elementary/switchboard-plug-locale/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	app-i18n/ibus[vala]
	dev-libs/glib:2
	dev-libs/granite:7
	gnome-base/gnome-desktop:4
	pantheon-base/switchboard:3
	sys-apps/accountsservice
	sys-auth/polkit
	gui-libs/gtk:4
	gui-libs/libadwaita:1
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
