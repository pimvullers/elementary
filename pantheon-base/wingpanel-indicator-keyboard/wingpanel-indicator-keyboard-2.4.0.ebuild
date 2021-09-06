# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.22

inherit gnome2-utils meson vala

DESCRIPTION="Keyboard indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-keyboard"
SRC_URI="https://github.com/elementary/wingpanel-indicator-keyboard/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	app-i18n/ibus[vala]
	dev-libs/glib:2
	dev-libs/granite
	pantheon-base/wingpanel
	x11-libs/gtk+:3
"

DEPEND="${RDEPEND}
	$(vala_depend)
	dev-libs/libxml2[python]
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
