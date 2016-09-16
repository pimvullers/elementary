# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit gnome2-utils cmake-utils bzr

DESCRIPTION="Default settings for the Pantheon Desktop Environment"
HOMEPAGE="https://code.launchpad.net/~elementary-os/elementaryos/default-settings-trusty"
EBZR_REPO_URI="lp:~elementary-os/elementaryos/default-settings-trusty"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	mv debian/elementary-default-settings.gsettings-override \
		${P}.gschema.override

	# Replace Open Sans with Droid Sans as we don't have Open Sans yet
	sed -i -e 's/Open Sans/Droid Sans/'	${P}.gschema.override

	# Rename DMZ-Black to Vanilla-DMZ-AA as that's the name in Gentoo
	sed -i -e 's/DMZ-Black/Vanilla-DMZ-AA/' ${P}.gschema.override

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	exeinto /usr/bin/
	doexe dpms/elementary-dpms-helper

	insinto /usr/share/applications/
	doins policykit.desktop

	insinto /usr/share/glib-2.0/schemas/
	doins ${P}.gschema.override

	insinto /etc/xdg/autostart/
	doins dpms/elementary-dpms-helper.desktop 
	
	insinto /etc/xdg/xdg-elementary/autostart/
	doins light-locker.desktop

	insinto /etc/xdg/midori/
	doins midori/config

	insinto /etc/profile.d/
	doins profile.d/*.sh

	insinto /etc/skel/.config/plank/
	doins -r plank/dock1

	insinto /etc/gtk-3.0/
	doins settings.ini
}

pkg_postinst() {
	GNOME2_ECLASS_GLIB_SCHEMAS=1 gnome2_schemas_update
}

pkg_postrm() {
	GNOME2_ECLASS_GLIB_SCHEMAS=1 gnome2_schemas_update
}
