# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.34

inherit gnome2-utils meson vala

DESCRIPTION="Adjust Locale settings using Switchboard."
HOMEPAGE="https://github.com/elementary/switchboard-plug-locale"
SRC_URI="https://github.com/elementary/switchboard-plug-locale/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	app-i18n/ibus[vala]
	dev-libs/glib:2
	dev-libs/granite
	gnome-base/gnome-desktop:3
	pantheon-base/switchboard
	sys-apps/accountsservice
	>=sys-auth/polkit-0.115
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
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
