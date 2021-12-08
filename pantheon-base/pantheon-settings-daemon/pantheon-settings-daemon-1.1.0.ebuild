# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala

DESCRIPTION="Pantheon settings daemon"
HOMEPAGE="https://github.com/elementary/settings-daemon"
SRC_URI="https://github.com/elementary/settings-daemon/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="systemd"

DEPEND=""
RDEPEND="${DEPEND}
	dev-libs/granite
	dev-libs/glib:2
	app-misc/geoclue:2.0
	systemd? ( sys-apps/systemd )
"

S="${WORKDIR}/settings-daemon-${PV}"

src_prepare() {
	eapply "${FILESDIR}/gsd-deprecated-missing.patch"
	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dsystemduserunitdir=$(usex systemd $(systemd_get_userunitdir) no)
	)
	meson_src_configure
}

pkg_preinst() {
	GNOME2_ECLASS_GLIB_SCHEMAS=1 gnome2_schemas_savelist
}

pkg_postinst() {
	GNOME2_ECLASS_GLIB_SCHEMAS=1 gnome2_schemas_update
}

pkg_postrm() {
	GNOME2_ECLASS_GLIB_SCHEMAS=1 gnome2_schemas_update
}
